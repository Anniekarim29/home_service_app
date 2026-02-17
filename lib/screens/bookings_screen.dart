import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';
import 'rate_service_screen.dart';
import '../services/rating_service.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  String _selectedFilter = 'Upcoming';
  final RatingService _ratingService = RatingService();

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
                      _buildFilterChip('Upcoming', _selectedFilter == 'Upcoming'),
                      const SizedBox(width: 15),
                      _buildFilterChip('Completed', _selectedFilter == 'Completed'),
                      const SizedBox(width: 15),
                      _buildFilterChip('Cancelled', _selectedFilter == 'Cancelled'),
                    ],
                  ),
                ).animate().fadeIn(delay: 100.ms),
                
                const SizedBox(height: 25),
                
                // Bookings List
                Expanded(
                  child: ListView(
                    children: [
                      _buildBookingCard(
                        'booking_1',
                        'Home Cleaning',
                        'Sara Ahmed',
                        'provider_1',
                        'Today, 10:00 AM - 12:00 PM',
                        'Completed',
                        AppTheme.neonGreen,
                        Icons.cleaning_services,
                        '\$45',
                        '4.9',
                      ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                      
                      const SizedBox(height: 15),
                      
                      _buildBookingCard(
                        'booking_2',
                        'Plumbing Repair',
                        'Ali Hassan',
                        'provider_2',
                        'Tomorrow, 2:00 PM - 4:00 PM',
                        'Confirmed',
                        AppTheme.neonBlue,
                        Icons.plumbing,
                        '\$80',
                        '4.8',
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                      
                      const SizedBox(height: 15),
                      
                      _buildBookingCard(
                        'booking_3',
                        'AC Service',
                        'Usman Gondal',
                        'provider_3',
                        'Dec 12, 11:30 AM - 1:30 PM',
                        'Pending',
                        AppTheme.goldAccent,
                        Icons.ac_unit,
                        '\$120',
                        '5.0',
                      ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                      
                      const SizedBox(height: 15),
                      
                      _buildBookingCard(
                        'booking_4',
                        'Electrical Work',
                        'Bilal Khan',
                        'provider_4',
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
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
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
      ),
    );
  }

  Widget _buildBookingCard(
    String bookingId,
    String title,
    String providerName,
    String providerId,
    String dateTime,
    String status,
    Color statusColor,
    IconData icon,
    String price,
    String rating,
  ) {
    final bool isCompleted = status == 'Completed';
    final bool hasRated = _ratingService.hasRated(bookingId);
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
          
          // Rate Service Button (only for completed bookings)
          if (isCompleted) ...[
            const SizedBox(height: 16),
            Container(
              height: 1,
              color: Colors.white.withOpacity(0.05),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: hasRated ? null : () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RateServiceScreen(
                      bookingId: bookingId,
                      serviceProviderId: providerId,
                      serviceName: title,
                      providerName: providerName,
                    ),
                  ),
                );
                if (result == true && mounted) {
                  setState(() {}); // Refresh to show rated status
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: hasRated ? null : AppTheme.neonGradient,
                  color: hasRated ? AppTheme.surfaceDark.withOpacity(0.3) : null,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: hasRated ? Colors.white.withOpacity(0.1) : Colors.transparent,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      hasRated ? Icons.check_circle : Icons.star_outline,
                      color: hasRated ? AppTheme.neonGreen : Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      hasRated ? 'Service Rated' : 'Rate Service',
                      style: AppTheme.bodyLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
