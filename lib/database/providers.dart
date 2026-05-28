import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trenni/database/database.dart';
import 'package:trenni/database/database_service.dart';

final databaseServiceProvider = Provider<DatabaseService>((ref) => DatabaseService());

final databaseProvider = StateProvider<AppDatabase?>((ref) => null);

final pocketsProvider = StreamProvider<List<Pocket>>((ref) {
  final db = ref.watch(databaseProvider);
  if (db == null) return const Stream.empty();
  return db.watchPockets();
});

final accountsProvider = StreamProvider<List<Account>>((ref) {
  final db = ref.watch(databaseProvider);
  if (db == null) return const Stream.empty();
  return db.watchAccounts();
});

final transactionsProvider = StreamProvider<List<TransactionWithRelations>>((ref) {
  final db = ref.watch(databaseProvider);
  if (db == null) return const Stream.empty();
  return db.watchTransactionsWithRelations();
});

class PocketWithBalances {
  final Pocket pocket;
  final double balance;
  final double spent;

  PocketWithBalances({
    required this.pocket,
    required this.balance,
    required this.spent,
  });
}

class AccountWithBalances {
  final Account account;
  final double balance;

  AccountWithBalances({
    required this.account,
    required this.balance,
  });
}

final pocketsWithBalancesProvider = Provider<AsyncValue<List<PocketWithBalances>>>((ref) {
  final pocketsAsync = ref.watch(pocketsProvider);
  final transactionsAsync = ref.watch(transactionsProvider);

  return pocketsAsync.when(
    data: (pockets) => transactionsAsync.when(
      data: (transactions) {
        final list = pockets.map((pocket) {
          double balance = 0.0;
          double spent = 0.0;
          for (final tx in transactions) {
            if (tx.transaction.pocketId == pocket.id) {
              balance += tx.transaction.amount;
              if (tx.transaction.amount < 0) {
                spent += tx.transaction.amount.abs();
              }
            }
            if (tx.transaction.transferToPocketId == pocket.id) {
              // Incoming virtual transfer adds to pocket balance
              balance += -tx.transaction.amount;
            }
          }
          return PocketWithBalances(
            pocket: pocket,
            balance: balance,
            spent: spent,
          );
        }).toList();
        return AsyncValue.data(list);
      },
      loading: () => const AsyncValue.loading(),
      error: (e, s) => AsyncValue.error(e, s),
    ),
    loading: () => const AsyncValue.loading(),
    error: (e, s) => AsyncValue.error(e, s),
  );
});

final accountsWithBalancesProvider = Provider<AsyncValue<List<AccountWithBalances>>>((ref) {
  final accountsAsync = ref.watch(accountsProvider);
  final transactionsAsync = ref.watch(transactionsProvider);

  return accountsAsync.when(
    data: (accounts) => transactionsAsync.when(
      data: (transactions) {
        final list = accounts.map((account) {
          double balance = 0.0;
          for (final tx in transactions) {
            if (tx.transaction.accountId == account.id) {
              balance += tx.transaction.amount;
            }
            if (tx.transaction.transferToAccountId == account.id) {
              // Incoming physical transfer adds to account balance
              balance += -tx.transaction.amount;
            }
          }
          return AccountWithBalances(
            account: account,
            balance: balance,
          );
        }).toList();
        return AsyncValue.data(list);
      },
      loading: () => const AsyncValue.loading(),
      error: (e, s) => AsyncValue.error(e, s),
    ),
    loading: () => const AsyncValue.loading(),
    error: (e, s) => AsyncValue.error(e, s),
  );
});
