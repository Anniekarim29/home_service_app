import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/service_card.dart';
import '../widgets/animated_widgets.dart';
import '../widgets/premium_background.dart';
import 'details_screen.dart';

class ServiceData {
  final String title;
  final String subtitle;
  final String price;
  final String originalPrice;
  final String imagePath;
  final Gradient gradient;
  final String category;

  ServiceData({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.originalPrice,
    required this.imagePath,
    required this.gradient,
    required this.category,
  });
}

class ServicesScreen extends StatelessWidget {
  final String categoryName;

  const ServicesScreen({super.key, this.categoryName = 'All'});

  static final List<ServiceData> _allServices = [
    ServiceData(
      title: 'Kitchen Cleaning',
      subtitle: 'Deep clean for your kitchen.',
      price: '\$80',
      originalPrice: '\$100',
      imagePath: 'assets/images/kitchen_cleaning.jpg',
      gradient: const LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      category: 'Cleaning',
    ),
    ServiceData(
      title: 'Car Washing',
      subtitle: 'Exterior & interior detail.',
      price: '\$40',
      originalPrice: '\$55',
      imagePath: 'assets/images/car_cleaning.jpg',
      gradient: const LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      category: 'Cleaning',
    ),
    ServiceData(
      title: 'Bathroom Cleaning',
      subtitle: 'Sanitized & sparkling.',
      price: '\$35',
      originalPrice: '\$50',
      imagePath: 'assets/images/bathroom_cleaning.jpg',
      gradient: const LinearGradient(
        colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      category: 'Cleaning',
    ),
    ServiceData(
      title: 'Sofa & Carpet',
      subtitle: 'Remove stains & odors.',
      price: '\$60',
      originalPrice: '\$85',
      imagePath: 'assets/images/sofa carpet_cleaning.jpg',
      gradient: const LinearGradient(
        colors: [Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      category: 'Cleaning',
    ),
    // Plumbing Data
    ServiceData(
      title: 'Pipe Leakage',
      subtitle: 'Fix leaking pipes fast.',
      price: '\$45',
      originalPrice: '\$60',
      imagePath: 'assets/images/plumbing_1.jpg', // Placeholder
      gradient: const LinearGradient(
        colors: [Color(0xFFE1F5FE), Color(0xFFB3E5FC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      category: 'Plumbing',
    ),
    // Electrician Data
    ServiceData(
      title: 'Wiring Fix',
      subtitle: 'Safe electrical repairs.',
      price: '\$50',
      originalPrice: '\$70',
      imagePath: 'assets/images/electrician_1.jpg', // Placeholder
      gradient: const LinearGradient(
        colors: [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      category: 'Electrician',
    ),
     ServiceData(
      title: 'Painting',
      subtitle: 'Wall painting service.',
      price: '\$150',
      originalPrice: '\$200',
      imagePath: 'assets/images/painting_1.jpg', // Placeholder
      gradient: const LinearGradient(
        colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      category: 'Painting',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredServices = categoryName == 'All' 
        ? _allServices 
        : _allServices.where((s) => s.category == categoryName).toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark, // Updated to match Home
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: FadeInSlideUp(
          delay: const Duration(milliseconds: 100),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: FadeInSlideUp(
          delay: const Duration(milliseconds: 200),
          child: Text(
            categoryName == 'All' ? 'Our Services' : '$categoryName Services',
            style: AppTheme.displayMedium.copyWith(fontSize: 22, color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: PremiumBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               if (categoryName == 'All' || categoryName == 'Cleaning') ...[
                // Featured Card (Top) - Only show for All or Cleaning for now
                FadeInSlideUp(
                  delay: const Duration(milliseconds: 400),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: AppTheme.neonGradient,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.neonPurple.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded, color: Colors.amber, size: 24),
                                  const SizedBox(width: 8),
                                  Text('Best Deal', style: AppTheme.displayMedium.copyWith(fontSize: 16, color: Colors.white)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Get 20% Off All Cleaning Services',
                                style: AppTheme.bodyMedium.copyWith(color: Colors.white.withOpacity(0.9), fontSize: 16, height: 1.4),
                              ),
                              const SizedBox(height: 15),
                              ScaleOnTap(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DetailsScreen(
                                        title: 'Home Cleaning',
                                        description: 'Get 20% Off All Cleaning Services',
                                        price: '\$120',
                                        originalPrice: '\$150',
                                        imagePath: 'assets/images/cleaning_women.jpg',
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text('Book Now', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/cleaning_women.jpg',
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
              
              FadeInSlideUp(
                delay: const Duration(milliseconds: 500),
                child: Text(
                  categoryName == 'All' ? 'All Services' : 'Available Services',
                  style: AppTheme.displayMedium.copyWith(fontSize: 20, color: Colors.white),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Grid of Services
              filteredServices.isEmpty 
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      'No services found for $categoryName',
                      style: AppTheme.bodyMedium.copyWith(color: Colors.white60),
                    ),
                  ),
                )
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredServices.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                     final service = filteredServices[index];
                     return _buildServiceGridItem(
                        context,
                        title: service.title,
                        subtitle: service.subtitle,
                        price: service.price,
                        originalPrice: service.originalPrice,
                        imagePath: service.imagePath, // Note: Ensure these assets exist or use placeholders
                        gradient: service.gradient,
                        delay: 600 + (index * 100),
                     );
                  },
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceGridItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String price,
    required String originalPrice,
    required String imagePath,
    required Gradient gradient,
    required int delay,
  }) {
    return FadeInSlideUp(
      delay: Duration(milliseconds: delay),
      child: ScaleOnTap(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                title: title,
                description: subtitle,
                price: price,
                originalPrice: originalPrice,
                imagePath: imagePath,
              ),
            ),
          );
        },
        child: ServiceCard(
          title: title,
          subtitle: subtitle,
          price: price,
          originalPrice: originalPrice,
          imagePath: imagePath,
          gradient: gradient,
          onTap: () {
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  title: title,
                  description: subtitle,
                  price: price,
                  originalPrice: originalPrice,
                  imagePath: imagePath,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
