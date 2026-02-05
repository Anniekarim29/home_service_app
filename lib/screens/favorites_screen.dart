import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';
import '../services/favorites_manager.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesManager _favoritesManager = FavoritesManager();

  IconData _getIconFromName(String iconName) {
    switch (iconName) {
      case 'cleaning_services':
        return Icons.cleaning_services;
      case 'kitchen':
        return Icons.kitchen;
      case 'bathroom':
        return Icons.bathroom;
      case 'directions_car':
        return Icons.directions_car;
      case 'weekend':
        return Icons.weekend;
      case 'plumbing':
        return Icons.plumbing;
      case 'water_drop':
        return Icons.water_drop;
      case 'hot_tub':
        return Icons.hot_tub;
      case 'electrical_services':
        return Icons.electrical_services;
      case 'lightbulb':
        return Icons.lightbulb;
      case 'power':
        return Icons.power;
      case 'ac_unit':
        return Icons.ac_unit;
      case 'hvac':
        return Icons.hvac;
      case 'format_paint':
        return Icons.format_paint;
      case 'home':
        return Icons.home;
      default:
        return Icons.home_repair_service;
    }
  }

  Color _getColorFromHex(String hexColor) {
    return Color(int.parse(hexColor.replaceAll('#', '0xFF')));
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
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Favorites',
                            style: AppTheme.displayMedium.copyWith(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ListenableBuilder(
                            listenable: _favoritesManager,
                            builder: (context, _) {
                              return Text(
                                '${_favoritesManager.favoritesCount} services saved',
                                style: AppTheme.bodyMedium.copyWith(
                                  color: Colors.white60,
                                  fontSize: 14,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    if (_favoritesManager.favoritesCount > 0)
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: AppTheme.surfaceDark,
                              title: Text(
                                'Clear All Favorites?',
                                style: AppTheme.displayMedium.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              content: Text(
                                'This will remove all services from your favorites.',
                                style: AppTheme.bodyMedium.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white60),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _favoritesManager.clearAll();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Clear All',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          'Clear All',
                          style: TextStyle(
                            color: AppTheme.neonPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2),
              ),

              // Content
              Expanded(
                child: ListenableBuilder(
                  listenable: _favoritesManager,
                  builder: (context, _) {
                    if (_favoritesManager.favoritesCount == 0) {
                      return _buildEmptyState();
                    }
                    return _buildFavoritesList();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppTheme.neonPurple.withOpacity(0.2),
                  AppTheme.neonBlue.withOpacity(0.2),
                ],
              ),
            ),
            child: Icon(
              Icons.favorite_border,
              size: 100,
              color: Colors.white38,
            ),
          ).animate().scale(duration: 500.ms),
          const SizedBox(height: 30),
          Text(
            'No Favorites Yet',
            style: AppTheme.displayMedium.copyWith(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              'Start adding services to your favorites by tapping the heart icon',
              textAlign: TextAlign.center,
              style: AppTheme.bodyMedium.copyWith(
                color: Colors.white60,
                height: 1.5,
              ),
            ).animate().fadeIn(delay: 300.ms),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.neonPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              shadowColor: AppTheme.neonPurple.withOpacity(0.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.search, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Browse Services',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: _favoritesManager.favoritesCount,
      itemBuilder: (context, index) {
        final service = _favoritesManager.favorites[index];
        return _buildFavoriteCard(service, index);
      },
    );
  }

  Widget _buildFavoriteCard(FavoriteService service, int index) {
    final icon = _getIconFromName(service.iconName);
    final color = _getColorFromHex(service.colorHex);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              title: service.title,
              description: service.subtitle,
              price: service.price,
              originalPrice: service.originalPrice,
              imagePath: 'assets/images/cleaning_women.jpg',
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: color.withOpacity(0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.withOpacity(0.3),
                              color.withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: color.withOpacity(0.3),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Icon(
                          icon,
                          color: color,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Title
                      Text(
                        service.title,
                        style: AppTheme.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Category
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          service.category,
                          style: AppTheme.bodySmall.copyWith(
                            color: color,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Rating and Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppTheme.goldAccent,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                service.rating.toString(),
                                style: AppTheme.bodySmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            service.price,
                            style: AppTheme.bodyLarge.copyWith(
                              color: AppTheme.neonGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Remove button
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      _favoritesManager.removeFavorite(service.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 20,
                      ),
                    )
                        .animate(
                          onPlay: (controller) => controller.repeat(reverse: true),
                        )
                        .scale(
                          duration: 1000.ms,
                          begin: const Offset(1, 1),
                          end: const Offset(1.1, 1.1),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: (index * 50).ms)
        .slideY(begin: 0.2);
  }
}
