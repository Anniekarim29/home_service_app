import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class ReviewsScreen extends StatefulWidget {
  final String serviceTitle;
  final double averageRating;
  final int totalReviews;

  const ReviewsScreen({
    super.key,
    required this.serviceTitle,
    this.averageRating = 4.6,
    this.totalReviews = 342,
  });

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  String _selectedFilter = 'All';
  String _selectedSort = 'Most Recent';

  final List<Map<String, dynamic>> _reviews = [
    {
      'userName': 'Sarah Ahmed',
      'userAvatar': '👩',
      'rating': 5.0,
      'date': '2 days ago',
      'service': 'Home Cleaning',
      'review': 'Absolutely fantastic service! The team was professional, thorough, and left my home sparkling clean. Highly recommend!',
      'helpfulCount': 24,
      'isHelpful': false,
      'color': AppTheme.neonPurple,
    },
    {
      'userName': 'Muhammad Ali',
      'userAvatar': '👨',
      'rating': 4.0,
      'date': '5 days ago',
      'service': 'AC Repair',
      'review': 'Good service overall. The technician arrived on time and fixed my AC quickly. Price was reasonable.',
      'helpfulCount': 18,
      'isHelpful': false,
      'color': AppTheme.neonBlue,
    },
    {
      'userName': 'Fatima Khan',
      'userAvatar': '👩‍🦰',
      'rating': 5.0,
      'date': '1 week ago',
      'service': 'Plumbing',
      'review': 'Excellent work! Fixed my leaking pipes and explained everything clearly. Very satisfied with the service.',
      'helpfulCount': 31,
      'isHelpful': false,
      'color': AppTheme.neonGreen,
    },
    {
      'userName': 'Omar Hassan',
      'userAvatar': '🧔',
      'rating': 3.0,
      'date': '1 week ago',
      'service': 'Electrical',
      'review': 'Service was okay, but they arrived a bit late. The work quality was good though.',
      'helpfulCount': 9,
      'isHelpful': false,
      'color': AppTheme.goldAccent,
    },
    {
      'userName': 'Aisha Malik',
      'userAvatar': '👩‍💼',
      'rating': 5.0,
      'date': '2 weeks ago',
      'service': 'Painting',
      'review': 'Beautiful painting job! The team was meticulous and the finish looks professional. Worth every penny!',
      'helpfulCount': 42,
      'isHelpful': false,
      'color': AppTheme.neonPurple,
    },
    {
      'userName': 'Ahmed Raza',
      'userAvatar': '👨‍💻',
      'rating': 4.0,
      'date': '3 weeks ago',
      'service': 'Carpentry',
      'review': 'Great craftsmanship! My custom furniture looks amazing. Minor delay in delivery but quality makes up for it.',
      'helpfulCount': 15,
      'isHelpful': false,
      'color': AppTheme.neonBlue,
    },
  ];

  final Map<int, int> _ratingDistribution = {
    5: 220,
    4: 85,
    3: 22,
    2: 10,
    1: 5,
  };

  void _toggleHelpful(int index) {
    setState(() {
      _reviews[index]['isHelpful'] = !_reviews[index]['isHelpful'];
      _reviews[index]['helpfulCount'] += _reviews[index]['isHelpful'] ? 1 : -1;
    });
  }

  List<Map<String, dynamic>> get _filteredReviews {
    List<Map<String, dynamic>> filtered = List.from(_reviews);
    
    // Filter by rating
    if (_selectedFilter != 'All') {
      int filterRating = int.parse(_selectedFilter.replaceAll('★', ''));
      filtered = filtered.where((r) => r['rating'].toInt() == filterRating).toList();
    }
    
    // Sort
    if (_selectedSort == 'Most Recent') {
      // Already in order
    } else if (_selectedSort == 'Highest Rated') {
      filtered.sort((a, b) => b['rating'].compareTo(a['rating']));
    } else if (_selectedSort == 'Most Helpful') {
      filtered.sort((a, b) => b['helpfulCount'].compareTo(a['helpfulCount']));
    }
    
    return filtered;
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reviews',
                            style: AppTheme.displayMedium.copyWith(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.serviceTitle,
                            style: AppTheme.bodySmall.copyWith(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideX(),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Overall Rating Card
                      _buildOverallRatingCard(),
                      
                      const SizedBox(height: 30),

                      // Rating Distribution
                      _buildRatingDistribution(),

                      const SizedBox(height: 30),

                      // Filter & Sort
                      _buildFilterAndSort(),

                      const SizedBox(height: 20),

                      // Reviews List
                      ..._filteredReviews.asMap().entries.map((entry) {
                        int index = _reviews.indexOf(entry.value);
                        return _buildReviewCard(entry.value, index);
                      }).toList(),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverallRatingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.neonPurple.withOpacity(0.2),
            AppTheme.neonBlue.withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppTheme.neonPurple.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.neonPurple.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            widget.averageRating.toStringAsFixed(1),
            style: AppTheme.displayLarge.copyWith(
              color: Colors.white,
              fontSize: 56,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < widget.averageRating.floor() ? Icons.star : Icons.star_border,
                color: AppTheme.goldAccent,
                size: 24,
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            'Based on ${widget.totalReviews} reviews',
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildRatingDistribution() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rating Distribution',
            style: AppTheme.bodyLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ..._ratingDistribution.entries.map((entry) {
            int stars = entry.key;
            int count = entry.value;
            double percentage = count / widget.totalReviews;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(
                    '$stars',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, color: AppTheme.goldAccent, size: 16),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: percentage,
                        backgroundColor: Colors.white.withOpacity(0.05),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          stars >= 4 ? AppTheme.neonGreen : 
                          stars >= 3 ? AppTheme.goldAccent : 
                          Colors.redAccent,
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$count',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
  }

  Widget _buildFilterAndSort() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ['All', '5★', '4★', '3★', '2★', '1★'].map((filter) {
              bool isSelected = _selectedFilter == filter;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedFilter = filter),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected 
                        ? AppTheme.neonPurple.withOpacity(0.2)
                        : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected 
                          ? AppTheme.neonPurple 
                          : Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? AppTheme.neonPurple : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        // Sort Dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: DropdownButton<String>(
            value: _selectedSort,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            underline: const SizedBox(),
            dropdownColor: AppTheme.surfaceDark,
            style: const TextStyle(color: Colors.white),
            items: ['Most Recent', 'Highest Rated', 'Most Helpful'].map((sort) {
              return DropdownMenuItem(
                value: sort,
                child: Text(sort),
              );
            }).toList(),
            onChanged: (value) => setState(() => _selectedSort = value!),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildReviewCard(Map<String, dynamic> review, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [review['color'], review['color'].withOpacity(0.5)],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: review['color'], width: 2),
                ),
                child: Text(
                  review['userAvatar'],
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['userName'],
                      style: AppTheme.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      review['date'],
                      style: AppTheme.bodySmall.copyWith(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.goldAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: AppTheme.goldAccent, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      review['rating'].toStringAsFixed(1),
                      style: const TextStyle(
                        color: AppTheme.goldAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: review['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              review['service'],
              style: TextStyle(
                color: review['color'],
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            review['review'],
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              GestureDetector(
                onTap: () => _toggleHelpful(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: review['isHelpful'] 
                      ? AppTheme.neonGreen.withOpacity(0.2)
                      : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: review['isHelpful']
                        ? AppTheme.neonGreen
                        : Colors.white.withOpacity(0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        size: 14,
                        color: review['isHelpful'] 
                          ? AppTheme.neonGreen 
                          : Colors.white.withOpacity(0.5),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Helpful (${review['helpfulCount']})',
                        style: TextStyle(
                          color: review['isHelpful'] 
                            ? AppTheme.neonGreen 
                            : Colors.white.withOpacity(0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: (400 + index * 100).ms).slideY(begin: 0.2);
  }
}
