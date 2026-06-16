import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trenni/database/database.dart';

void main() {
  group('Database Persistence Unit Tests', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory(
        setup: (rawDb) {
          rawDb.execute('PRAGMA foreign_keys = ON;'); // Enforce reference integrity
        },
      ));
    });

    tearDown(() async {
      await db.close();
    });

    test('Verify SQLite3MC Encryption Engine is active', () async {
      final result = await db.customSelect("SELECT sqlite3mc_config('cipher');").getSingle();
      expect(result.data.values.first, isNotEmpty, reason: 'SQLite3MC extension should be active');
    });

    test('Amount precision double-to-cents conversion', () async {
      const converter = AmountConverter();
      expect(converter.toSql(10.50), 1050);
      expect(converter.toSql(-5.00), -500);
      expect(converter.toSql(0.00), 0);
      expect(converter.toSql(12.3456), 1235); // rounding check
      
      expect(converter.fromSql(1050), 10.50);
      expect(converter.fromSql(-500), -5.00);
    });

    test('Pockets, Accounts and Transactions CRUD flow', () async {
      final accountId = 'acc-1';
      final pocketId = 'pock-1';
      final txId = 'tx-1';

      // 1. Create account and pocket
      await db.into(db.accounts).insert(AccountsCompanion.insert(
        id: Value(accountId),
        name: 'Checking Account',
        currency: 'USD',
        iconCodePoint: 12345,
      ));

      await db.into(db.pockets).insert(PocketsCompanion.insert(
        id: Value(pocketId),
        name: 'Groceries Pocket',
        iconCodePoint: 54321,
      ));

      // 2. Create transaction
      await db.into(db.transactions).insert(TransactionsCompanion.insert(
        id: Value(txId),
        name: 'Starbucks',
        amount: -5.50,
        timestamp: DateTime.now(),
        accountId: accountId,
        pocketId: Value(pocketId),
      ));

      // 3. Verify joined relations query
      final relations = await db.watchTransactionsWithRelations().first;
      expect(relations.length, 1);
      expect(relations.first.transaction.id, txId);
      expect(relations.first.account.name, 'Checking Account');
      expect(relations.first.pocket?.name, 'Groceries Pocket');
      expect(relations.first.transaction.amount, -5.50);

      // Verify exact raw database integer storage (cents)
      final rawAmount = await db.customSelect("SELECT amount FROM transactions WHERE id = '$txId';").getSingle();
      expect(rawAmount.data['amount'], -550);
    });

    test('Enforce foreign keys & cascading deletions', () async {
      final accountId = 'acc-cascade';
      final pocketId = 'pocket-setnull';
      final txId = 'tx-ref';

      await db.into(db.accounts).insert(AccountsCompanion.insert(
        id: Value(accountId),
        name: 'Checking Account',
        currency: 'USD',
        iconCodePoint: 1,
      ));

      await db.into(db.pockets).insert(PocketsCompanion.insert(
        id: Value(pocketId),
        name: 'Groceries',
        iconCodePoint: 2,
      ));

      await db.into(db.transactions).insert(TransactionsCompanion.insert(
        id: Value(txId),
        name: 'Whole Foods',
        amount: -12.34,
        timestamp: DateTime.now(),
        accountId: accountId,
        pocketId: Value(pocketId),
      ));

      // Delete the pocket: should set pocketId to null (KeyAction.setNull)
      await db.deletePocket(pocketId);
      var currentTxs = await db.watchTransactionsWithRelations().first;
      expect(currentTxs.length, 1);
      expect(currentTxs.first.pocket, isNull, reason: 'pocket reference should be set to null on delete');

      // Delete the account: should cascade delete the transaction (KeyAction.cascade)
      await db.deleteAccount(accountId);
      currentTxs = await db.watchTransactionsWithRelations().first;
      expect(currentTxs.isEmpty, isTrue, reason: 'transaction should be cascade deleted when account is deleted');
    });
  });
}
