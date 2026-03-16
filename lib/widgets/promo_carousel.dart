import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../theme/app_theme.dart';
import '../screens/details_screen.dart';

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  final PageController _pageController = PageController();
  
  final List<Promotion> _promotions = [
    Promotion(
      title: '30% OFF',
      subtitle: 'Home Cleaning Service',
      tag: 'TRENDING',
      description: 'Get 30% Off Home Cleaning',
      price: '\$100',
      originalPrice: '\$140',
      imagePath: 'assets/images/cleaning_women.jpg',
      baseColor: AppTheme.neonPurple,
      accentColor: AppTheme.neonBlue,
      icon: Icons.cleaning_services,
    ),
    Promotion(
      title: '20% OFF',
      subtitle: 'Kitchen Cleaning',
      tag: 'POPULAR',
      description: 'Professional kitchen deep cleaning',
      price: '\$60',
      originalPrice: '\$80',
      imagePath: 'assets/images/kitchen_cleaning.jpg',
      baseColor: AppTheme.neonGreen,
      accentColor: AppTheme.neonBlue,
      icon: Icons.kitchen,
    ),
    Promotion(
      title: 'HOT DEAL',
      subtitle: 'Plumbing Works',
      tag: 'LIMITED',
      description: 'Expert plumbing services',
      price: '\$45',
      originalPrice: '\$60',
      imagePath: 'assets/images/plumber_man.jpg',
      baseColor: AppTheme.goldAccent,
      accentColor: Colors.orange,
      icon: Icons.plumbing,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _promotions.length,
            itemBuilder: (context, index) {
              final promo = _promotions[index];
              return _buildPromoCard(context, promo);
            },
          ),
        ),
        const SizedBox(height: 15),
        SmoothPageIndicator(
          controller: _pageController,
          count: _promotions.length,
          effect: ExpandingDotsEffect(
            activeDotColor: AppTheme.neonBlue,
            dotColor: Colors.white.withOpacity(0.2),
            dotHeight: 8,
            dotWidth: 8,
            expansionFactor: 4,
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCard(BuildContext context, Promotion promo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [
                  promo.baseColor,
                  promo.accentColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: promo.baseColor.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: [
                  Positioned(
                    left: 24,
                    top: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          promo.title,
                          style: AppTheme.displayMedium.copyWith(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          promo.subtitle,
                          style: AppTheme.bodyLarge.copyWith(
                            color: Colors.white.withOpacity(0.95),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 18),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  title: promo.subtitle,
                                  description: promo.description,
                                  price: promo.price,
                                  originalPrice: promo.originalPrice,
                                  imagePath: promo.imagePath,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: promo.baseColor,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Book Now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Opacity(
                      opacity: 0.2,
                      child: Icon(
                        promo.icon,
                        size: 160,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    color: Colors.orange,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    promo.tag,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2000.ms),
          ),
        ],
      ),
    );
  }
}

class Promotion {
  final String title;
  final String subtitle;
  final String tag;
  final String description;
  final String price;
  final String originalPrice;
  final String imagePath;
  final Color baseColor;
  final Color accentColor;
  final IconData icon;

  Promotion({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.imagePath,
    required this.baseColor,
    required this.accentColor,
    required this.icon,
  });
}
