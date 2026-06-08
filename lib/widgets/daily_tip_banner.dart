import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class DailyTipBanner extends StatelessWidget {
  const DailyTipBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real app, tip could be fetched from an API or stored locally.
    const tip = "Save energy by turning off lights when not in use!";
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppTheme.neonGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.neonPurple.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: AppTheme.bodyMedium.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2);
  }
}
