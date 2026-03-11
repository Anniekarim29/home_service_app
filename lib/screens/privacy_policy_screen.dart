import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                      'Privacy Policy',
                      style: AppTheme.displayMedium.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideX(),

              const SizedBox(height: 20),

              // Content List
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceDark,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('1. Information We Collect'),
                        _buildSectionText(
                          'We collect information you provide directly to us, such as when you create or modify your account, request services, contact customer support, or otherwise communicate with us. This info may include: name, email, phone number, postal address, profile picture, payment method, and other info you provide.',
                        ),
                        const SizedBox(height: 20),
                        _buildSectionTitle('2. How We Use Information'),
                        _buildSectionText(
                          'We use the information we collect to provide, maintain, and improve our services, such as to facilitate payments, send receipts, provide products and services you request (and send related information), develop new features, provide customer support, and send updates.',
                        ),
                        const SizedBox(height: 20),
                        _buildSectionTitle('3. Sharing of Information'),
                        _buildSectionText(
                          'We may share the information we collect about you as described in this Statement or as described at the time of collection or sharing, including with Home Service Professionals to enable them to provide the Services you request.',
                        ),
                        const SizedBox(height: 20),
                        _buildSectionTitle('4. Account Information'),
                        _buildSectionText(
                          'You may correct your account information at any time by logging into your account. If you wish to cancel your account, please email us or use the delete account option in Settings, but note that we may retain certain info as required by law.',
                        ),
                        const SizedBox(height: 20),
                        _buildSectionTitle('5. Changes to the Policy'),
                        _buildSectionText(
                          'We may occasionally update this policy. If you use our services after an update, you consent to the changed policy.',
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: Text(
                            'Last Updated: December 2025',
                            style: AppTheme.bodySmall.copyWith(
                              color: Colors.white.withOpacity(0.4),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: AppTheme.bodyLarge.copyWith(
          color: AppTheme.neonPurple,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildSectionText(String text) {
    return Text(
      text,
      style: AppTheme.bodyMedium.copyWith(
        color: Colors.white.withOpacity(0.8),
        height: 1.5,
      ),
    );
  }
}
