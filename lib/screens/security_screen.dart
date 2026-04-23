import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _biometricEnabled = true;
  bool _twoFactorEnabled = false;
  bool _appLockEnabled = true;

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
                      'Security',
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

              // Security List
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _buildSecuritySection(
                        'Access Control',
                        [
                          _buildSwitchTile(
                            Icons.fingerprint_outlined,
                            'Biometric Login',
                            AppTheme.neonBlue,
                            _biometricEnabled,
                            (value) => setState(() => _biometricEnabled = value),
                          ),
                          _buildSwitchTile(
                            Icons.lock_outline,
                            'App Lock',
                            AppTheme.neonPurple,
                            _appLockEnabled,
                            (value) => setState(() => _appLockEnabled = value),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      _buildSecuritySection(
                        'Authentication',
                        [
                          _buildSwitchTile(
                            Icons.security_outlined,
                            'Two-Factor Auth',
                            AppTheme.neonGreen,
                            _twoFactorEnabled,
                            (value) => setState(() => _twoFactorEnabled = value),
                          ),
                          _buildSecurityTile(
                            Icons.password_outlined,
                            'Change Password',
                            AppTheme.goldAccent,
                            () => _showPlaceholderDialog(context, 'Change Password'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      _buildSecuritySection(
                        'Sessions',
                        [
                          _buildSecurityTile(
                            Icons.devices_outlined,
                            'Active Sessions',
                            AppTheme.neonBlue,
                            () => _showPlaceholderDialog(context, 'Active Sessions'),
                          ),
                          _buildSecurityTile(
                            Icons.history_outlined,
                            'Login History',
                            AppTheme.neonPurple,
                            () => _showPlaceholderDialog(context, 'Login History'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      // Security Status Badge
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.neonGreen.withOpacity(0.1),
                              AppTheme.neonBlue.withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppTheme.neonGreen.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.neonGreen.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.verified_user_outlined,
                                color: AppTheme.neonGreen,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Account Secure',
                                    style: AppTheme.bodyLarge.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Your account security is at 85%. Enable 2FA to reach 100%.',
                                    style: AppTheme.bodySmall.copyWith(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 400.ms).scale(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecuritySection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title,
            style: AppTheme.bodySmall.copyWith(
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityTile(
    IconData icon,
    String title,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTheme.bodyLarge.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withOpacity(0.3),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    IconData icon,
    String title,
    Color iconColor,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: AppTheme.bodyLarge.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: iconColor,
            activeTrackColor: iconColor.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  void _showPlaceholderDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'This is a placeholder for the $title feature.',
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: AppTheme.neonPurple)),
          ),
        ],
      ),
    );
  }
}
