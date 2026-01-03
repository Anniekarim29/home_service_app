import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double _balance = 1240.50;
  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'Home Cleaning',
      'subtitle': 'Dec 22, 2025',
      'amount': '-\$85.00',
      'icon': Icons.cleaning_services,
      'color': AppTheme.neonBlue,
    },
    {
      'title': 'Wallet Top-up',
      'subtitle': 'Dec 20, 2025',
      'amount': '+\$500.00',
      'icon': Icons.add_circle_outline,
      'color': AppTheme.neonGreen,
    },
    {
      'title': 'AC Repair',
      'subtitle': 'Dec 18, 2025',
      'amount': '-\$120.00',
      'icon': Icons.ac_unit,
      'color': AppTheme.goldAccent,
    },
  ];

  void _handleTopUp(double amount) {
    setState(() {
      _balance += amount;
      _transactions.insert(0, {
        'title': 'Wallet Top-up',
        'subtitle': 'Just now',
        'amount': '+\$${amount.toStringAsFixed(2)}',
        'icon': Icons.add_circle_outline,
        'color': AppTheme.neonGreen,
      });
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully added \$${amount.toStringAsFixed(0)} to wallet!'),
        backgroundColor: AppTheme.neonGreen.withOpacity(0.8),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showTopUpSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Top Up Wallet',
              style: AppTheme.displayMedium.copyWith(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              'Select an amount to add',
              style: AppTheme.bodyMedium.copyWith(color: Colors.white54),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [10, 20, 50, 100, 200, 500].map((amount) {
                return InkWell(
                  onTap: () => _handleTopUp(amount.toDouble()),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.neonPurple.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(12),
                      color: AppTheme.neonPurple.withOpacity(0.1),
                    ),
                    child: Text(
                      '\$$amount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: PremiumBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Wallet & Rewards',
                      style: AppTheme.displayMedium.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Transaction History is coming soon!',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: AppTheme.surfaceDark,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: const Icon(Icons.history, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideX(),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Balance Card
                      _buildBalanceCard(),
                      
                      const SizedBox(height: 30),

                      // Rewards Section
                      _buildRewardsSection(),

                      const SizedBox(height: 30),

                      // Transactions Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Transactions',
                            style: AppTheme.bodyLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'All transactions history view is coming soon!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: AppTheme.surfaceDark,
                                ),
                              );
                            },
                            child: Text(
                              'See all',
                              style: AppTheme.bodySmall.copyWith(
                                color: AppTheme.neonBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 300.ms),

                      const SizedBox(height: 15),

                      // Transactions List
                      _buildTransactionList(),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.neonPurple,
            AppTheme.neonBlue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppTheme.neonPurple.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Balance',
                style: AppTheme.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(Icons.account_balance_wallet_outlined, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${_balance.toStringAsFixed(2)}',
            style: AppTheme.displayMedium.copyWith(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildActionButton(Icons.add, 'Top Up', Colors.white.withOpacity(0.2), onTap: _showTopUpSheet),
              const SizedBox(width: 12),
              _buildActionButton(Icons.file_upload_outlined, 'Send', Colors.white.withOpacity(0.1), onTap: () {
                 ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Send feature coming soon!'),
                      backgroundColor: AppTheme.surfaceDark,
                    ),
                  );
              }),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildActionButton(IconData icon, String label, Color bgColor, {required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.goldAccent.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.goldAccent.withOpacity(0.1),
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.goldAccent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.stars, color: AppTheme.goldAccent, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Reward Points',
                style: AppTheme.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.goldAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.goldAccent.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified, color: AppTheme.goldAccent, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      'Gold Member',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.goldAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                '850 pts',
                style: TextStyle(
                  color: AppTheme.goldAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.85,
              backgroundColor: Colors.white.withOpacity(0.05),
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.goldAccent),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Only 150 points to go for your next reward!',
            style: AppTheme.bodySmall.copyWith(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
  }

  Widget _buildTransactionList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        final tx = _transactions[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Transaction details coming soon!',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: AppTheme.surfaceDark,
                  ),
                );
              },
              borderRadius: BorderRadius.circular(20),
              splashColor: tx['color'].withOpacity(0.1),
              highlightColor: tx['color'].withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: tx['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(tx['icon'], color: tx['color'], size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx['title'],
                            style: AppTheme.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            tx['subtitle'],
                            style: AppTheme.bodySmall.copyWith(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      tx['amount'],
                      style: TextStyle(
                        color: tx['amount'].startsWith('+') ? AppTheme.neonGreen : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1);
  }
}
