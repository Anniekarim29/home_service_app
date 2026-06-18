import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

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
                      'About App',
                      style: AppTheme.displayMedium.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideX(),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      
                      // Glowing App Icon
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppTheme.neonGradient,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.neonPurple.withOpacity(0.4),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                            BoxShadow(
                              color: AppTheme.neonBlue.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: AppTheme.backgroundDark,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.home_repair_service_outlined,
                            size: 70,
                            color: Colors.white,
                          ),
                        ),
                      ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),

                      const SizedBox(height: 24),

                      // Title & Version
                      Text(
                        'Home Service App',
                        style: AppTheme.displayMedium.copyWith(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                      const SizedBox(height: 8),
                      Text(
                        'Version 1.0.0',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.neonBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ).animate().fadeIn(delay: 300.ms),

                      const SizedBox(height: 40),

                      // Description Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white.withOpacity(0.05)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.rocket_launch_outlined, color: AppTheme.neonPurple, size: 24),
                                const SizedBox(width: 12),
                                Text(
                                  'Our Mission',
                                  style: AppTheme.displayMedium.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'To empower households by providing seamless, premium home services right to your doorstep. We bridge the gap between skilled local service providers and home owners with absolute reliability, transparency, and safety.',
                              style: AppTheme.bodyLarge.copyWith(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

                      const SizedBox(height: 20),

                      // Key Features Grid/List
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white.withOpacity(0.05)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star_outline, color: AppTheme.goldAccent, size: 24),
                                const SizedBox(width: 12),
                                Text(
                                  'Core Offerings',
                                  style: AppTheme.displayMedium.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildFeatureRow(Icons.check_circle_outline, 'Verified Service Experts', 'Every professional is background checked and certified.'),
                            const SizedBox(height: 12),
                            _buildFeatureRow(Icons.bolt, 'Instant Online Booking', 'Schedule plumbing, cleaning, or repairs in seconds.'),
                            const SizedBox(height: 12),
                            _buildFeatureRow(Icons.security, 'Secure Payments', 'Pay with integrated wallet or credit card with safety assurance.'),
                          ],
                        ),
                      ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),

                      const SizedBox(height: 40),

                      // Footer Attribution
                      Text(
                        'Designed & Crafted with ❤️',
                        style: AppTheme.bodySmall.copyWith(
                          color: Colors.white.withOpacity(0.3),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'by Annie Karim',
                        style: AppTheme.bodySmall.copyWith(
                          color: Colors.white.withOpacity(0.3),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 40),
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

  Widget _buildFeatureRow(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppTheme.neonBlue, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTheme.bodySmall.copyWith(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
