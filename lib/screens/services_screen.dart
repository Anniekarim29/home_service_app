import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/service_card.dart';
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
      ),
      category: 'Cleaning',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredServices = categoryName == 'All' 
        ? _allServices 
        : _allServices.where((s) => s.category == categoryName).toList();

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
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                    ),
                    Expanded(
                      child: Text(
                        categoryName == 'All' ? 'Our Services' : '$categoryName Services',
                        style: AppTheme.displayMedium.copyWith(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 40), // Balance the back button
                  ],
                ),
              ),
              
              // Services List
              Expanded(
                child: filteredServices.isEmpty 
                  ? Center(
                      child: Text(
                        'No services found',
                        style: AppTheme.bodyMedium.copyWith(color: Colors.white60),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      itemCount: filteredServices.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final service = filteredServices[index];
                        return ServiceCard(
                          title: service.title,
                          subtitle: service.subtitle,
                          price: service.price,
                          originalPrice: service.originalPrice,
                          imagePath: service.imagePath,
                          gradient: service.gradient,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  title: service.title,
                                  description: service.subtitle,
                                  price: service.price,
                                  originalPrice: service.originalPrice,
                                  imagePath: service.imagePath,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
