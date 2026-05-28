import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:trenni/database/database.dart';
import 'package:trenni/database/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _seedMockData(BuildContext context, AppDatabase db) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: colorScheme.error),
            const SizedBox(width: 12),
            const Text('Confirm Reset & Seed'),
          ],
        ),
        content: const Text(
          'This will delete all current pockets, accounts, and transactions in your database, then seed it with standard mock data. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Confirm Reset'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await db.transaction(() async {
        // 1. Delete all existing records
        await db.delete(db.transactions).go();
        await db.delete(db.pockets).go();
        await db.delete(db.accounts).go();

        // 2. Insert accounts
        final checkingId = 'checking-uuid';
        final ccId = 'credit-card-uuid';
        final investId = 'investment-uuid';

        await db.into(db.accounts).insert(AccountsCompanion.insert(
          id: drift.Value(checkingId),
          name: 'Checking',
          currency: 'USD',
          iconCodePoint: Icons.account_balance_outlined.codePoint,
          iconFontFamily: drift.Value(Icons.account_balance_outlined.fontFamily),
        ));

        await db.into(db.accounts).insert(AccountsCompanion.insert(
          id: drift.Value(ccId),
          name: 'Credit Card',
          currency: 'USD',
          iconCodePoint: Icons.credit_card_outlined.codePoint,
          iconFontFamily: drift.Value(Icons.credit_card_outlined.fontFamily),
        ));

        await db.into(db.accounts).insert(AccountsCompanion.insert(
          id: drift.Value(investId),
          name: 'Investment',
          currency: 'USD',
          iconCodePoint: Icons.trending_up_outlined.codePoint,
          iconFontFamily: drift.Value(Icons.trending_up_outlined.fontFamily),
        ));

        // 3. Insert pockets
        final groceryId = 'pocket-grocery';
        final entertainmentId = 'pocket-entertainment';
        final savingsId = 'pocket-savings';
        final transportId = 'pocket-transport';
        final incomeId = 'pocket-income';
        final healthId = 'pocket-health';

        await db.into(db.pockets).insert(PocketsCompanion.insert(
          id: drift.Value(groceryId),
          name: 'Groceries',
          iconCodePoint: Icons.shopping_cart_outlined.codePoint,
          iconFontFamily: drift.Value(Icons.shopping_cart_outlined.fontFamily),
        ));

        await db.into(db.pockets).insert(PocketsCompanion.insert(
          id: drift.Value(entertainmentId),
          name: 'Entertainment',
          iconCodePoint: Icons.movie_outlined.codePoint,
          iconFontFamily: drift.Value(Icons.movie_outlined.fontFamily),
        ));

        await db.into(db.pockets).insert(PocketsCompanion.insert(
          id: drift.Value(savingsId),
          name: 'Savings',
          iconCodePoint: Icons.savings_outlined.codePoint,
          iconFontFamily: drift.Value(Icons.savings_outlined.fontFamily),
        ));

        await db.into(db.pockets).insert(PocketsCompanion.insert(
          id: drift.Value(transportId),
          name: 'Transport',
          iconCodePoint: Icons.directions_bus_outlined.codePoint,
          iconFontFamily: drift.Value(Icons.directions_bus_outlined.fontFamily),
        ));

        await db.into(db.pockets).insert(PocketsCompanion.insert(
          id: drift.Value(incomeId),
          name: 'Income',
          iconCodePoint: Icons.savings_outlined.codePoint,
          iconFontFamily: drift.Value(Icons.savings_outlined.fontFamily),
        ));

        await db.into(db.pockets).insert(PocketsCompanion.insert(
          id: drift.Value(healthId),
          name: 'Health',
          iconCodePoint: Icons.health_and_safety_outlined.codePoint,
          iconFontFamily: drift.Value(Icons.health_and_safety_outlined.fontFamily),
        ));

        // 4. Insert Transactions
        final now = DateTime.now();

        Future<void> addTx(String name, double amount, DateTime timestamp, String accountId, String? pocketId, {String? emoji}) async {
          await db.into(db.transactions).insert(TransactionsCompanion.insert(
            name: name,
            amount: amount,
            timestamp: timestamp,
            accountId: accountId,
            pocketId: drift.Value(pocketId),
            emoji: drift.Value(emoji),
          ));
        }

        // Seeding transactions
        await addTx('Starbucks', -5.50, now.subtract(const Duration(hours: 3)), checkingId, groceryId, emoji: '☕');
        await addTx('Monthly Salary', 3500.00, now.subtract(const Duration(days: 1)), checkingId, incomeId, emoji: '💰');
        await addTx('Netflix', -15.99, now.subtract(const Duration(days: 2)), ccId, entertainmentId, emoji: '📺');
        await addTx('Gas Station', -45.00, now.subtract(const Duration(days: 3)), checkingId, transportId, emoji: '⛽');
        await addTx('Whole Foods', -120.50, now.subtract(const Duration(days: 4)), checkingId, groceryId, emoji: '🥦');
        await addTx('Apple Music', -9.99, now.subtract(const Duration(days: 5)), ccId, entertainmentId, emoji: '🎵');
        await addTx('Uber Ride', -25.00, now.subtract(const Duration(days: 7)), checkingId, transportId, emoji: '🚗');
        await addTx('Gym Membership', -50.00, now.subtract(const Duration(days: 12)), checkingId, healthId, emoji: '💪');
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Database reset and mock data seeded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error seeding mock data: $e'),
            backgroundColor: colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final db = ref.watch(databaseProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          _buildSectionHeader(theme, 'Preferences'),
          _buildCardContainer(colorScheme, [
            _buildListTile(
              context,
              icon: Icons.palette_outlined,
              title: 'Appearance',
              subtitle: 'System Default Theme',
              onTap: () {},
            ),
            _buildDivider(colorScheme),
            _buildListTile(
              context,
              icon: Icons.notifications_none_outlined,
              title: 'Notifications',
              subtitle: 'Configure budget alerts',
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionHeader(theme, 'Security'),
          _buildCardContainer(colorScheme, [
            _buildListTile(
              context,
              icon: Icons.fingerprint_outlined,
              title: 'Biometric Lock',
              subtitle: 'Use Face ID / Fingerprint on startup',
              onTap: () {},
              trailing: Switch(value: true, onChanged: (_) {}),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionHeader(theme, 'Debug Tools'),
          _buildCardContainer(colorScheme, [
            _buildListTile(
              context,
              icon: Icons.refresh_outlined,
              title: 'Seed Mock Data',
              subtitle: 'Resets database and loads sample transactions',
              onTap: () => _seedMockData(context, db!),
              textColor: colorScheme.error,
              iconColor: colorScheme.error,
            ),
          ]),
          const SizedBox(height: 32),
          Center(
            child: Text(
              'Trenni v1.0.0 (Local-Persistence Beta)',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        text,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildCardContainer(ColorScheme colorScheme, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
    Color? textColor,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? theme.colorScheme.primary).withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor ?? theme.colorScheme.primary, size: 20),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: trailing ?? Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant, size: 20),
      onTap: trailing == null ? onTap : null,
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Divider(
      height: 1,
      indent: 56,
      endIndent: 16,
      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
    );
  }
}
