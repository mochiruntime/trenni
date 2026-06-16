import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

class AmountConverter extends TypeConverter<double, int> {
  const AmountConverter();
  @override
  double fromSql(int fromDb) => fromDb / 100.0;
  @override
  int toSql(double value) => (value * 100).round();
}

class TransactionWithRelations {
  final Transaction transaction;
  final Account account;
  final Pocket? pocket;
  final Account? transferToAccount;
  final Pocket? transferToPocket;

  TransactionWithRelations({
    required this.transaction,
    required this.account,
    this.pocket,
    this.transferToAccount,
    this.transferToPocket,
  });
}

class Pockets extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text().unique()();
  IntColumn get iconCodePoint => integer()();
  TextColumn get iconFontFamily => text().nullable()();
  IntColumn get colorValue => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Accounts extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text().unique()();
  TextColumn get currency => text().withLength(min: 3, max: 3)(); // ISO 4217 code (e.g. 'USD')
  IntColumn get iconCodePoint => integer()();
  TextColumn get iconFontFamily => text().nullable()();
  IntColumn get colorValue => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Transactions extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  IntColumn get amount => integer().map(const AmountConverter())(); // Exact cents storage
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get notes => text().nullable()();
  TextColumn get emoji => text().nullable()();
  
  // Physical Layer (Non-nullable)
  TextColumn get accountId => text().references(Accounts, #id, onDelete: KeyAction.cascade)();
  
  // Budget Layer (Nullable)
  TextColumn get pocketId => text().nullable().references(Pockets, #id, onDelete: KeyAction.setNull)();
  
  // Optional Split Hierarchy
  TextColumn get parentTransactionId => text().nullable().references(Transactions, #id, onDelete: KeyAction.cascade)();

  // Optional Transfers
  TextColumn get transferToAccountId => text().nullable().references(Accounts, #id, onDelete: KeyAction.setNull)();
  TextColumn get transferToPocketId => text().nullable().references(Pockets, #id, onDelete: KeyAction.setNull)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Pockets, Accounts, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  // Streams
  Stream<List<Pocket>> watchPockets() => select(pockets).watch();
  Stream<List<Account>> watchAccounts() => select(accounts).watch();

  Stream<List<TransactionWithRelations>> watchTransactionsWithRelations() {
    final transferAcc = alias(accounts, 'transfer_acc');
    final transferPock = alias(pockets, 'transfer_pock');

    final query = select(transactions).join([
      leftOuterJoin(accounts, accounts.id.equalsExp(transactions.accountId)),
      leftOuterJoin(pockets, pockets.id.equalsExp(transactions.pocketId)),
      leftOuterJoin(transferAcc, transferAcc.id.equalsExp(transactions.transferToAccountId)),
      leftOuterJoin(transferPock, transferPock.id.equalsExp(transactions.transferToPocketId)),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithRelations(
          transaction: row.readTable(transactions),
          account: row.readTable(accounts),
          pocket: row.readTableOrNull(pockets),
          transferToAccount: row.readTableOrNull(transferAcc),
          transferToPocket: row.readTableOrNull(transferPock),
        );
      }).toList();
    });
  }

  // Mutations
  Future<int> insertPocket(PocketsCompanion companion) => into(pockets).insert(companion);
  Future<int> insertAccount(AccountsCompanion companion) => into(accounts).insert(companion);
  Future<int> insertTransaction(TransactionsCompanion companion) => into(transactions).insert(companion);
  Future<bool> updatePocket(Pocket pocket) => update(pockets).replace(pocket);
  Future<bool> updateAccount(Account account) => update(accounts).replace(account);
  Future<bool> updateTransaction(Transaction transaction) => update(transactions).replace(transaction);
  Future<int> deletePocket(String id) => (delete(pockets)..where((t) => t.id.equals(id))).go();
  Future<int> deleteAccount(String id) => (delete(accounts)..where((t) => t.id.equals(id))).go();
  Future<int> deleteTransaction(String id) => (delete(transactions)..where((t) => t.id.equals(id))).go();
}

LazyDatabase openConnection(String passphrase) {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(p.join(dbFolder.path, 'trenni.db'));
    return NativeDatabase.createInBackground(
      file,
      setup: (rawDb) {
        rawDb.execute('PRAGMA foreign_keys = ON;'); // Enforce reference integrity
        assert(_debugCheckHasCipher(rawDb), 'SQLite3MultipleCiphers is not available! Verify your build hooks.');
        rawDb.execute("PRAGMA key = '${passphrase.replaceAll("'", "''")}';");
      },
    );
  });
}

bool _debugCheckHasCipher(Database database) {
  return database.select('PRAGMA cipher;').isNotEmpty;
}
