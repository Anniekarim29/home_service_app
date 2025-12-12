import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String originalPrice;
  final String imagePath;
  final Gradient gradient;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.originalPrice,
    required this.imagePath,
    required this.gradient,
    required this.onTap,
  });

  Color _getAccentColor() {
    // Extract color from gradient for accent
    if (gradient is LinearGradient) {
      final colors = (gradient as LinearGradient).colors;
      if (colors.isNotEmpty) {
        // Map light colors to neon equivalents
        final firstColor = colors.first;
        if (firstColor.red > 200 && firstColor.green < 200 && firstColor.blue < 200) {
          return AppTheme.neonPurple; // Pink/Purple gradients
        } else if (firstColor.blue > 200 && firstColor.red < 200) {
          return AppTheme.neonBlue; // Blue gradients
        } else if (firstColor.green > 200 && firstColor.red < 200) {
          return AppTheme.neonGreen; // Green gradients
        } else if (firstColor.red > 200 && firstColor.green > 200) {
          return AppTheme.goldAccent; // Yellow/Orange gradients
        }
      }
    }
    return AppTheme.neonPurple; // Default
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = _getAccentColor();
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: accentColor.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Row(
            children: [
              // Left Side - Text Content
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: AppTheme.displayMedium.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: AppTheme.bodyMedium.copyWith(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            price,
                            style: AppTheme.displayMedium.copyWith(
                              fontSize: 20,
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            originalPrice,
                            style: AppTheme.bodyMedium.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.white38,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              // Right Side - Image & Arrow
              Expanded(
                flex: 2,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image with gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            accentColor.withOpacity(0.3),
                            accentColor.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback if image doesn't exist
                          return Container(
                            color: accentColor.withOpacity(0.2),
                            child: Icon(
                              Icons.image_not_supported,
                              color: accentColor.withOpacity(0.5),
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Gradient overlay for better icon visibility
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    
                    // Arrow Button
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withOpacity(0.4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
