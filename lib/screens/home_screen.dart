import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../theme/app_theme.dart';
import 'services_screen.dart';
import 'details_screen.dart';
import 'notifications_screen.dart';
import '../widgets/premium_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === HEADER: User Profile & Greeting ===
                Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppTheme.neonGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.neonPurple.withOpacity(0.4),
                                    blurRadius: 15,
                                  ),
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 24,
                                backgroundImage: AssetImage(
                                  'assets/images/profile.jpeg',
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Good Evening 👋',
                                  style: AppTheme.bodyMedium.copyWith(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 2),

                                /// ✅ NAME CHANGED HERE
                                Text(
                                  'Annie Karim',
                                  style: AppTheme.displayMedium.copyWith(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NotificationsScreen(),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceDark,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.neonPurple.withOpacity(0.3),
                                      blurRadius: 15,
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child:
                                    Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppTheme.backgroundDark,
                                              width: 2,
                                            ),
                                          ),
                                        )
                                        .animate(
                                          onPlay: (controller) =>
                                              controller.repeat(),
                                        )
                                        .scale(
                                          duration: 1000.ms,
                                          begin: const Offset(1, 1),
                                          end: const Offset(1.2, 1.2),
                                        ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                    /// ✅ NEW SMOOTH ANIMATION ADDED
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideX(begin: -0.2)
                    .scale(begin: const Offset(0.9, 0.9)),

                const SizedBox(height: 25),

                // === SEARCH: Premium Search Bar ===
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.neonBlue.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.white54, size: 22),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search for services...',
                            hintStyle: AppTheme.bodyMedium.copyWith(
                              color: Colors.white38,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: AppTheme.neonGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),

                const SizedBox(height: 25),

                // === STATS: Quick Insights Dashboard ===
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        '24',
                        'Bookings',
                        AppTheme.neonBlue,
                        Icons.calendar_today,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        '\$340',
                        'Saved',
                        AppTheme.neonGreen,
                        Icons.savings_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        '12',
                        'Services',
                        AppTheme.goldAccent,
                        Icons.home_repair_service,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),

                const SizedBox(height: 25),

                // === PROMO: Featured Campaign Hero Section ===
                Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.neonPurple,
                                AppTheme.neonBlue,
                                const Color(0xFF00D4FF),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.neonPurple.withOpacity(0.5),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                              ),
                              BoxShadow(
                                color: AppTheme.neonBlue.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 24,
                                    top: 40,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '30% OFF',
                                          style: AppTheme.displayMedium
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: 36,
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 1,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Home Cleaning Service',
                                          style: AppTheme.bodyLarge.copyWith(
                                            color: Colors.white.withOpacity(
                                              0.95,
                                            ),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Limited Time Offer',
                                          style: AppTheme.bodySmall.copyWith(
                                            color: Colors.white.withOpacity(
                                              0.8,
                                            ),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 18),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const DetailsScreen(
                                                      title: 'Home Cleaning',
                                                      description:
                                                          'Get 30% Off Home Cleaning',
                                                      price: '\$100',
                                                      originalPrice: '\$140',
                                                      imagePath:
                                                          'assets/images/cleaning_women.jpg',
                                                    ),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor:
                                                AppTheme.neonPurple,
                                            elevation: 0,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 28,
                                              vertical: 14,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                'Book Now',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              const Icon(
                                                Icons.arrow_forward,
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: -30,
                                    bottom: -20,
                                    child: Opacity(
                                      opacity: 0.3,
                                      child: Icon(
                                        Icons.cleaning_services,
                                        size: 180,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child:
                              Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.local_fire_department,
                                          color: Colors.orange,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'TRENDING',
                                          style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .animate(
                                    onPlay: (controller) => controller.repeat(),
                                  )
                                  .shimmer(
                                    duration: 2000.ms,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(delay: 300.ms)
                    .slideY(begin: 0.2)
                    .scale(delay: 300.ms),

                const SizedBox(height: 30),

                // CATEGORIES TITLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: AppTheme.displayMedium.copyWith(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'See all',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.neonBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 400.ms),

                const SizedBox(height: 20),

                // === CATEGORY CARDS WITH NEW ANIMATION ===
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildPremiumCategoryCard(
                        context,
                        'All Services',
                        Icons.apps,
                        AppTheme.neonPurple,
                        'All',
                        '50+',
                      ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9)),

                      _buildPremiumCategoryCard(
                            context,
                            'Cleaning',
                            Icons.cleaning_services,
                            AppTheme.neonBlue,
                            'Cleaning',
                            '12',
                          )
                          .animate()
                          .fadeIn(delay: 100.ms)
                          .scale(begin: const Offset(0.9, 0.9)),

                      _buildPremiumCategoryCard(
                            context,
                            'Plumbing',
                            Icons.plumbing,
                            AppTheme.neonGreen,
                            'Plumbing',
                            '8',
                          )
                          .animate()
                          .fadeIn(delay: 150.ms)
                          .scale(begin: const Offset(0.9, 0.9)),

                      _buildPremiumCategoryCard(
                            context,
                            'Electrical',
                            Icons.electrical_services,
                            AppTheme.goldAccent,
                            'Electrician',
                            '10',
                          )
                          .animate()
                          .fadeIn(delay: 200.ms)
                          .scale(begin: const Offset(0.9, 0.9)),

                      _buildPremiumCategoryCard(
                            context,
                            'Painting',
                            Icons.format_paint,
                            Colors.pinkAccent,
                            'Painting',
                            '6',
                          )
                          .animate()
                          .fadeIn(delay: 250.ms)
                          .scale(begin: const Offset(0.9, 0.9)),
                    ],
                  ),
                ).animate().fadeIn(delay: 500.ms).slideX(begin: 0.2),

                const SizedBox(height: 30),

                // Rest of your original code continues EXACTLY the same …
                // (I did not change anything below this point)
                // ---------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Featured',
                          style: AppTheme.displayMedium.copyWith(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppTheme.neonGradient,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'HOT',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'View all',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.neonBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 600.ms),

                const SizedBox(height: 20),

                SizedBox(
                  height: 160,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFeaturedServiceCard(
                        'Deep Cleaning',
                        '\$89',
                        '4.9',
                        AppTheme.neonBlue,
                        Icons.cleaning_services,
                      ),
                      _buildFeaturedServiceCard(
                        'AC Repair',
                        '\$120',
                        '5.0',
                        AppTheme.goldAccent,
                        Icons.ac_unit,
                      ),
                      _buildFeaturedServiceCard(
                        'Plumbing Fix',
                        '\$75',
                        '4.8',
                        AppTheme.neonGreen,
                        Icons.plumbing,
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 700.ms).slideX(begin: 0.2),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Rated',
                      style: AppTheme.displayMedium.copyWith(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'See all',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.neonBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 800.ms),

                const SizedBox(height: 20),

                Column(
                  children:
                      [
                            _buildPopularServiceItem(
                              'Home Cleaning',
                              'Starts from \$20',
                              '4.8 (1.2k bookings)',
                              AppTheme.neonBlue,
                              Icons.cleaning_services,
                            ),
                            const SizedBox(height: 15),
                            _buildPopularServiceItem(
                              'AC Repair & Service',
                              'Starts from \$50',
                              '4.9 (800 bookings)',
                              AppTheme.goldAccent,
                              Icons.ac_unit,
                            ),
                            const SizedBox(height: 15),
                            _buildPopularServiceItem(
                              'Plumbing Services',
                              'Starts from \$35',
                              '4.7 (650 bookings)',
                              AppTheme.neonGreen,
                              Icons.plumbing,
                            ),
                          ]
                          .animate(interval: 100.ms)
                          .fadeIn(delay: 900.ms)
                          .slideY(begin: 0.1),
                ),

                const SizedBox(height: 30),

                Text(
                  'Quick Actions',
                  style: AppTheme.displayMedium.copyWith(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(delay: 1000.ms),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _buildQuickActionButton(
                        '🚨 Emergency',
                        Colors.red,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildQuickActionButton(
                        '📍 Track Booking',
                        AppTheme.neonBlue,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 1100.ms).slideY(begin: 0.1),

                const SizedBox(height: 30),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.neonGreen.withOpacity(0.2),
                        AppTheme.neonGreen.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppTheme.neonGreen.withOpacity(0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.neonGreen.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.neonGreen.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.card_giftcard,
                          color: AppTheme.neonGreen,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Refer & Earn',
                              style: AppTheme.displayMedium.copyWith(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Get \$20 for each friend',
                              style: AppTheme.bodyMedium.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppTheme.neonGreen, Colors.greenAccent],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.neonGreen.withOpacity(0.4),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: const Text(
                          'Invite',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 1200.ms).scale(delay: 1200.ms),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =================
  // Helper widgets
  // =================

  Widget _buildStatCard(
    String value,
    String label,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTheme.displayMedium.copyWith(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTheme.bodySmall.copyWith(
              color: Colors.white60,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumCategoryCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String categoryName,
    String count,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServicesScreen(categoryName: categoryName),
          ),
        );
      },
      child: Container(
        width: 110,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: AppTheme.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(height: 4),
            Text(
              '$count services',
              style: AppTheme.bodySmall.copyWith(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedServiceCard(
    String title,
    String price,
    String rating,
    Color color,
    IconData icon,
  ) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: color.withOpacity(0.4)),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: AppTheme.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      'From ',
                      style: AppTheme.bodySmall.copyWith(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      price,
                      style: AppTheme.bodyLarge.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularServiceItem(
    String title,
    String price,
    String rating,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: color.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(color: color.withOpacity(0.2), blurRadius: 10),
              ],
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTheme.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.3),
                            color.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: color.withOpacity(0.3)),
                      ),
                      child: Text(
                        price,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: AppTheme.bodySmall.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Book',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        label,
        style: AppTheme.bodyLarge.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
