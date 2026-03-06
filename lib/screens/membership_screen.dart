import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: PremiumBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Prime Membership',
                      style: AppTheme.displayMedium.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideX(),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.goldAccent.withOpacity(0.1),
                          ),
                          child: const Icon(Icons.star, color: AppTheme.goldAccent, size: 80),
                        ).animate().scale(delay: 200.ms, duration: 400.ms),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Unlock Premium Benefits',
                        style: AppTheme.displayMedium.copyWith(
                          color: AppTheme.goldAccent,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 300.ms).slideY(),
                      const SizedBox(height: 10),
                      Text(
                        'Get the most out of our home services with a Prime Membership.',
                        style: AppTheme.bodyLarge.copyWith(color: Colors.white.withOpacity(0.7)),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 400.ms).slideY(),
                      const SizedBox(height: 40),
                      
                      _buildBenefitItem(Icons.local_shipping_outlined, 'Free priority routing', 500),
                      const SizedBox(height: 20),
                      _buildBenefitItem(Icons.discount_outlined, '10% off all services', 600),
                      const SizedBox(height: 20),
                      _buildBenefitItem(Icons.support_agent_outlined, '24/7 dedicated support', 700),
                      
                      const SizedBox(height: 50),
                      
                      // Subscribe Button
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                             ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(
                                 content: Text('Membership subscription started!'),
                                 backgroundColor: AppTheme.goldAccent,
                               ),
                             );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.goldAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Subscribe for \$9.99/mo',
                            style: AppTheme.bodyLarge.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.5),
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

  Widget _buildBenefitItem(IconData icon, String title, int delay) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.goldAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: AppTheme.goldAccent),
        ),
        const SizedBox(width: 20),
        Text(
          title,
          style: AppTheme.bodyLarge.copyWith(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.2);
  }
}
