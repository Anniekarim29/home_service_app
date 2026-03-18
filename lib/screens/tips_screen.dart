import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  final List<Map<String, dynamic>> _tips = const [
    {
      'title': 'HVAC Filter Replacement',
      'description': 'Replace your HVAC filters every 1-3 months to maintain air quality and efficiency.',
      'icon': Icons.air_outlined,
      'color': AppTheme.neonBlue,
    },
    {
      'title': 'Plumbing Leak Check',
      'description': 'Inspect under sinks for leaks and check water pressure regularly to prevent pipe bursts.',
      'icon': Icons.water_drop_outlined,
      'color': AppTheme.neonGreen,
    },
    {
      'title': 'Deep Cleaning Habits',
      'description': 'Schedule a deep clean for carpets and upholstery twice a year to prolong their lifespan.',
      'icon': Icons.cleaning_services_outlined,
      'color': AppTheme.neonPurple,
    },
    {
      'title': 'Electrical Safety',
      'description': 'Test your smoke detectors monthly and avoid overloading power outlets.',
      'icon': Icons.electrical_services_outlined,
      'color': AppTheme.goldAccent,
    },
    {
      'title': 'Lawn Care Timing',
      'description': 'Water your lawn early in the morning to minimize evaporation and fungal growth.',
      'icon': Icons.grass_outlined,
      'color': Colors.greenAccent,
    },
  ];

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
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Home Tips',
                      style: AppTheme.displayMedium.copyWith(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideX(),

              // Tips List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  itemCount: _tips.length,
                  itemBuilder: (context, index) {
                    final tip = _tips[index];
                    return _buildTipCard(tip, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tip, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: tip['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: tip['color'].withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: tip['color'].withOpacity(0.2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(tip['icon'], color: tip['color'], size: 28),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip['title'],
                  style: AppTheme.displaySmall.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tip['description'],
                  style: AppTheme.bodyMedium.copyWith(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 100 * index)).slideY(begin: 0.2);
  }
}
