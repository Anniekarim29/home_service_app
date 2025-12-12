import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: PremiumBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Bookings',
                      style: AppTheme.displayMedium.copyWith(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
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
                      child: const Icon(Icons.filter_list, color: Colors.white, size: 22),
                    ),
                  ],
                ).animate().fadeIn().slideX(),
                
                const SizedBox(height: 25),
                
                // Filter Tabs
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Upcoming', true),
                      const SizedBox(width: 15),
                      _buildFilterChip('Completed', false),
                      const SizedBox(width: 15),
                      _buildFilterChip('Cancelled', false),
                    ],
                  ),
                ).animate().fadeIn(delay: 100.ms),
                
                const SizedBox(height: 25),
                
                // Bookings List
                Expanded(
                  child: ListView(
                    children: [
                      _buildBookingCard(
                        'Home Cleaning',
                        'Sara Ahmed',
                        'Today, 10:00 AM - 12:00 PM',
                        'In Progress',
                        AppTheme.neonGreen,
                        Icons.cleaning_services,
                        '\$45',
                        '4.9',
                      ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                      
                      const SizedBox(height: 15),
                      
                      _buildBookingCard(
                        'Plumbing Repair',
                        'Ali Hassan',
                        'Tomorrow, 2:00 PM - 4:00 PM',
                        'Confirmed',
                        AppTheme.neonBlue,
                        Icons.plumbing,
                        '\$80',
                        '4.8',
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                      
                      const SizedBox(height: 15),
                      
                      _buildBookingCard(
                        'AC Service',
                        'Usman Gondal',
                        'Dec 12, 11:30 AM - 1:30 PM',
                        'Pending',
                        AppTheme.goldAccent,
                        Icons.ac_unit,
                        '\$120',
                        '5.0',
                      ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                      
                      const SizedBox(height: 15),
                      
                      _buildBookingCard(
                        'Electrical Work',
                        'Bilal Khan',
                        'Dec 15, 9:00 AM - 11:00 AM',
                        'Scheduled',
                        AppTheme.neonPurple,
                        Icons.electrical_services,
                        '\$95',
                        '4.7',
                      ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
                      
                      const SizedBox(height: 100), // Bottom spacer
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        gradient: isSelected ? AppTheme.neonGradient : null,
        color: isSelected ? null : AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.1),
        ),
        boxShadow: isSelected ? [
          BoxShadow(
            color: AppTheme.neonPurple.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ] : [],
      ),
      child: Text(
        label,
        style: AppTheme.bodyLarge.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildBookingCard(
    String title,
    String providerName,
    String dateTime,
    String status,
    Color statusColor,
    IconData icon,
    String price,
    String rating,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Icon Container
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withOpacity(0.2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Icon(icon, color: statusColor, size: 28),
              ),
              
              const SizedBox(width: 16),
              
              // Title and Provider
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Colors.white60,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          providerName,
                          style: AppTheme.bodyMedium.copyWith(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Divider
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.05),
          ),
          
          const SizedBox(height: 16),
          
          // Date, Time, Price, Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Date & Time
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: AppTheme.neonBlue,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        dateTime,
                        style: AppTheme.bodyMedium.copyWith(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Rating
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Price
              Text(
                price,
                style: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.neonGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
