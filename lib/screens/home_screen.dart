import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trenni/database/database.dart';
import 'package:trenni/database/providers.dart';
import 'package:trenni/screens/settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 16,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Trenni ',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            ActionChip(
              onPressed: () {},
              label: Text(
                'Oct 12, 2023 - Nov 12, 2023',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: colorScheme.surfaceContainerHighest,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
            icon: const Icon(Icons.settings_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Riverpod automatically updates streams, so refresh is implicit
          ref.invalidate(transactionsProvider);
          ref.invalidate(pocketsProvider);
          ref.invalidate(accountsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            0,
            16,
            0,
            MediaQuery.of(context).padding.bottom + 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pockets Section
              const _PocketsSection(),
              const SizedBox(height: 12),
              const _BalanceGraph(),
              const SizedBox(height: 12),
  
              // Accounts Section
              const _AccountsSection(),
              const SizedBox(height: 12),
  
              // Transactions Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Recent Transactions',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const _TransactionsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PocketsSection extends ConsumerWidget {
  const _PocketsSection();

  double _getLimit(String name) {
    switch (name.toLowerCase()) {
      case 'groceries':
        return 500.0;
      case 'entertainment':
        return 150.0;
      case 'transport':
        return 100.0;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pocketsState = ref.watch(pocketsWithBalancesProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return pocketsState.when(
      data: (pockets) {
        if (pockets.isEmpty) {
          return const SizedBox.shrink(); // Hide section if empty
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: Row(
            children: pockets.map((pocketWithBalance) {
              final pocket = pocketWithBalance.pocket;
              final balance = pocketWithBalance.balance;
              final spent = pocketWithBalance.spent;
              final limit = _getLimit(pocket.name);

              return Container(
                width: 220,
                margin: const EdgeInsets.only(right: 12),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getIconData(pocket.iconCodePoint),
                              size: 20,
                              color: pocket.colorValue != null ? Color(pocket.colorValue!) : colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                pocket.name,
                                style: theme.textTheme.titleSmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '\$${balance.toStringAsFixed(2)}',
                          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Spent: \$${spent.toStringAsFixed(2)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        if (limit > 0)
                          Text(
                            'Limit: \$${limit.toStringAsFixed(2)}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
      loading: () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Row(
          children: List.generate(3, (index) => _buildPocketSkeleton(context)),
        ),
      ),
      error: (error, stackTrace) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Text('Error loading pockets: $error'),
      ),
    );
  }

  Widget _buildPocketSkeleton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(width: 20, height: 20, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Container(width: 80, height: 16, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4))),
                ],
              ),
              const SizedBox(height: 16),
              Container(width: 120, height: 24, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4))),
              const SizedBox(height: 12),
              Container(width: 100, height: 12, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4))),
              const SizedBox(height: 4),
              Container(width: 80, height: 12, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4))),
            ],
          ),
        ),
      ),
    );
  }
}

class _BalanceGraph extends ConsumerWidget {
  const _BalanceGraph();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsState = ref.watch(transactionsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 220,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(top: 20, right: 24, left: 8, bottom: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: transactionsState.when(
        data: (transactions) {
          if (transactions.isEmpty) {
            return const Center(
              child: Text(
                'No transactions. Seed mock data in settings!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            );
          }

          // Sort chronologically ascending for the timeline graph
          final sorted = transactions.toList()
            ..sort((a, b) => a.transaction.timestamp.compareTo(b.transaction.timestamp));

          double runningBalance = 3000.0; // Baseline balance
          List<FlSpot> spots = [];
          
          // Add first baseline point
          spots.add(FlSpot(0, runningBalance));

          for (int i = 0; i < sorted.length; i++) {
            runningBalance += sorted[i].transaction.amount;
            spots.add(FlSpot((i + 1).toDouble(), runningBalance));
          }

          final minX = 0.0;
          final maxX = spots.length.toDouble() - 1;
          
          final yValues = spots.map((s) => s.y).toList();
          final minY = yValues.reduce((a, b) => a < b ? a : b) - 200.0;
          final maxY = yValues.reduce((a, b) => a > b ? a : b) + 200.0;

          return LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < spots.length) {
                        final date = index == 0
                            ? sorted.first.transaction.timestamp.subtract(const Duration(days: 1))
                            : sorted[index - 1].transaction.timestamp;
                        
                        final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                        final labelText = '${months[date.month - 1]} ${date.day}';

                        // Show every 2nd label to prevent layout overlaps
                        if (index % 2 == 0 || index == spots.length - 1) {
                          return SideTitleWidget(
                            meta: meta,
                            space: 8,
                            child: Text(
                              labelText, 
                              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)
                            ),
                          );
                        }
                      }
                      return Container();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 500,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        meta: meta,
                        space: 8,
                        child: Text(
                          '\$${(value / 1000).toStringAsFixed(1)}k',
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                    reservedSize: 42,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              minX: minX,
              maxX: maxX,
              minY: minY,
              maxY: maxY,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: colorScheme.primary,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colorScheme.primary.withValues(alpha: 0.2),
                        colorScheme.primary.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error rendering chart: $error'),
        ),
      ),
    );
  }
}

class _AccountsSection extends ConsumerWidget {
  const _AccountsSection();

  double _getExpected(String name) {
    switch (name.toLowerCase()) {
      case 'checking':
        return 450.0;
      case 'credit card':
        return 800.0;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsState = ref.watch(accountsWithBalancesProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return accountsState.when(
      data: (accounts) {
        if (accounts.isEmpty) {
          return const SizedBox.shrink(); // Hide section if empty
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
          child: Row(
            children: accounts.map((accountWithBalance) {
              final account = accountWithBalance.account;
              final balance = accountWithBalance.balance;
              final expected = _getExpected(account.name);

              return Container(
                width: 180,
                margin: const EdgeInsets.only(right: 12),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getIconData(account.iconCodePoint),
                              size: 16,
                              color: account.colorValue != null ? Color(account.colorValue!) : colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                account.name,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${balance.toStringAsFixed(2)}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (expected > 0) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Expected: \$${expected.toStringAsFixed(2)}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
      loading: () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
        child: Row(
          children: List.generate(3, (index) => _buildAccountSkeleton(context)),
        ),
      ),
      error: (error, stackTrace) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Error loading accounts: $error'),
      ),
    );
  }

  Widget _buildAccountSkeleton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(width: 16, height: 16, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Container(width: 60, height: 12, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4))),
                ],
              ),
              const SizedBox(height: 8),
              Container(width: 100, height: 20, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4))),
              const SizedBox(height: 4),
              Container(width: 80, height: 10, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4))),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionsSection extends ConsumerWidget {
  const _TransactionsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsState = ref.watch(transactionsProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return transactionsState.when(
      data: (transactions) {
        if (transactions.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(32),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.receipt_long_outlined, size: 48, color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
                  const SizedBox(height: 16),
                  Text(
                    'No transaction records found.',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Go to Settings (top right) -> Debug Tools to seed mock transactions for testing.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          );
        }

        // Sort descending so the most recent shows up at the top
        final sorted = transactions.toList()
          ..sort((a, b) => b.transaction.timestamp.compareTo(a.transaction.timestamp));

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: sorted.length,
          itemBuilder: (context, index) {
            return _TransactionItem(tx: sorted[index]);
          },
        );
      },
      loading: () => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) => _buildTransactionSkeleton(context),
      ),
      error: (error, stackTrace) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Error loading transactions: $error'),
      ),
    );
  }

  Widget _buildTransactionSkeleton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(width: 48, height: 48, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 100, height: 16, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4))),
                    Container(width: 60, height: 16, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4))),
                  ],
                ),
                const SizedBox(height: 4),
                Container(width: 80, height: 12, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4))),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(width: 60, height: 16, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4))),
                    const SizedBox(width: 8),
                    Container(width: 60, height: 16, decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(4))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final TransactionWithRelations tx;

  const _TransactionItem({required this.tx});

  String _getEmoji(String? pocketName, String name) {
    if (tx.transaction.emoji != null && tx.transaction.emoji!.isNotEmpty) {
      return tx.transaction.emoji!;
    }

    final n = name.toLowerCase();
    if (n.contains('starbucks')) return '☕';
    if (n.contains('apple music')) return '🎵';
    if (n.contains('netflix')) return '📺';
    if (n.contains('gas station')) return '⛽';
    if (n.contains('uber')) return '🚗';
    if (n.contains('salary')) return '💰';
    if (n.contains('gym')) return '💪';
    if (n.contains('whole foods')) return '🥦';

    if (pocketName == null) return '📝';
    switch (pocketName.toLowerCase()) {
      case 'groceries':
        return '🛒';
      case 'income':
        return '💰';
      case 'entertainment':
        return '🎭';
      case 'transport':
        return '🚲';
      case 'health':
        return '🏥';
      default:
        return '📝';
    }
  }

  String _formatTimestamp(DateTime dt) {
    final now = DateTime.now();
    if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
      return 'Today, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    final yesterday = now.subtract(const Duration(days: 1));
    if (dt.year == yesterday.year && dt.month == yesterday.month && dt.day == yesterday.day) {
      return 'Yesterday, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final amount = tx.transaction.amount;
    final isPositive = amount > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  _getEmoji(tx.pocket?.name, tx.transaction.name),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          tx.transaction.name,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${isPositive ? '+' : ''}\$${amount.abs().toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isPositive ? Colors.green.shade700 : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTimestamp(tx.transaction.timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tx.pocket?.name ?? 'Uncategorized',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tx.transferToAccount != null
                              ? '${tx.account.name} → ${tx.transferToAccount!.name}'
                              : tx.account.name,
                          style: theme.textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

IconData _getIconData(int codePoint) {
  if (codePoint == Icons.account_balance_outlined.codePoint) {
    return Icons.account_balance_outlined;
  }
  if (codePoint == Icons.credit_card_outlined.codePoint) {
    return Icons.credit_card_outlined;
  }
  if (codePoint == Icons.trending_up_outlined.codePoint) {
    return Icons.trending_up_outlined;
  }
  if (codePoint == Icons.shopping_cart_outlined.codePoint) {
    return Icons.shopping_cart_outlined;
  }
  if (codePoint == Icons.movie_outlined.codePoint) {
    return Icons.movie_outlined;
  }
  if (codePoint == Icons.savings_outlined.codePoint) {
    return Icons.savings_outlined;
  }
  if (codePoint == Icons.directions_bus_outlined.codePoint) {
    return Icons.directions_bus_outlined;
  }
  if (codePoint == Icons.health_and_safety_outlined.codePoint) {
    return Icons.health_and_safety_outlined;
  }
  return Icons.help_outline;
}

