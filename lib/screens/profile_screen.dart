import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';
import 'notifications_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                // Header with back button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: AppTheme.displayMedium.copyWith(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsScreen()),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.neonPurple.withOpacity(0.2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.settings, color: Colors.white, size: 22),
                      ),
                    ),
                  ],
                ).animate().fadeIn().slideX(),
                
                const SizedBox(height: 40),
                
                // Profile Image with Neon Glow
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppTheme.neonGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.neonPurple.withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                      BoxShadow(
                        color: AppTheme.neonBlue.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppTheme.backgroundDark,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage('assets/images/profile.jpeg'),
                    ),
                  ),
                ).animate().scale(delay: 100.ms, duration: 600.ms),
                
                const SizedBox(height: 20),
                
                // Name with Bold Font
                Text(
                  'Annie',
                  style: AppTheme.displayMedium.copyWith(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(delay: 200.ms),
                
                const SizedBox(height: 8),
                
                // Email with Better Contrast
                Text(
                  'annie@example.com',
                  style: AppTheme.bodyLarge.copyWith(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ).animate().fadeIn(delay: 300.ms),
                
                const SizedBox(height: 40),
                
                // Settings Container with Dark Theme
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildSettingsTile(Icons.person_outline, 'Edit Profile', AppTheme.neonBlue),
                      const SizedBox(height: 20),
                      _buildSettingsTile(Icons.payment_outlined, 'Payment Methods', AppTheme.neonPurple),
                      const SizedBox(height: 20),
                      _buildSettingsTile(Icons.location_on_outlined, 'Saved Addresses', AppTheme.goldAccent),
                      const SizedBox(height: 20),
                      _buildSettingsTile(
                        Icons.notifications_outlined,
                        'Notifications',
                        Colors.redAccent,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildSettingsTile(Icons.security_outlined, 'Security', AppTheme.neonGreen),
                      const SizedBox(height: 20),
                      _buildSettingsTile(
                        Icons.help_outline,
                        'Help & Support',
                        AppTheme.neonBlue,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsScreen()),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                
                const SizedBox(height: 30),
                
                // Logout Button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red.shade600, Colors.red.shade400],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        'Logout',
                        style: AppTheme.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 500.ms),
                
                const SizedBox(height: 100), // Bottom spacer for nav bar
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, Color iconColor, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent, // Ensures hit test covers the whole area
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: iconColor.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: iconColor.withOpacity(0.2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.white.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
