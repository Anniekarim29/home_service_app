import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class DetailsScreen extends StatefulWidget {
  final String title;
  final String description;
  final String price;
  final String originalPrice;
  final String imagePath;

  const DetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.imagePath,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String selectedPlan = 'Classic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: PremiumBackground(
        child: Stack(
          children: [
          // Hero Image Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 400,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE1BEE7), Color(0xFFF3E5F5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Hero( // Added Hero animation
                      tag: widget.imagePath,
                      child: Image.asset(
                        widget.imagePath,
                        height: 380,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Gradient Overlay for text readability
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.backgroundLight,
                            AppTheme.backgroundLight.withOpacity(0.0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Back Button & Cart
          Positioned(
            top: 50,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back_ios, size: 18, color: AppTheme.textDark),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.shopping_cart_outlined, size: 20, color: AppTheme.textDark),
                ),
              ],
            ),
          ),
          
          // Content Sheet
          Positioned(
            top: 350,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppTheme.backgroundLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: AppTheme.displayMedium.copyWith(fontSize: 22),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.description,
                                style: AppTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD7F5E6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Up to',
                                style: AppTheme.bodyMedium.copyWith(fontSize: 10),
                              ),
                              Text(
                                '30% Off',
                                style: AppTheme.displayMedium.copyWith(fontSize: 14, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Row(
                      children: [
                        Text(
                          widget.price,
                          style: AppTheme.displayLarge.copyWith(fontSize: 28),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.originalPrice,
                          style: AppTheme.bodyMedium.copyWith(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Pricing Plans
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPlanChip('Classic', widget.price),
                        _buildPlanChip('Premium', '\$${(int.tryParse(widget.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0) + 20}'),
                        _buildPlanChip('Platinum', '\$${(int.tryParse(widget.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0) + 40}'),
                      ],
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Worker Info
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage('assets/images/plumber_man.jpg'), // Placeholder
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Marcus Mane',
                                  style: AppTheme.displayMedium.copyWith(fontSize: 16),
                                ),
                                Text(
                                  'Service Man',
                                  style: AppTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              _buildActionButton(Icons.phone_outlined),
                              const SizedBox(width: 10),
                              _buildActionButton(Icons.chat_bubble_outline),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    Text(
                      'Service Description',
                      style: AppTheme.displayMedium.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Our ${widget.title} service delivers a thorough, spotless clean for every corner of your house. Enjoy a fresh, hygienic, and comfortable living space with professional care.',
                      style: AppTheme.bodyMedium.copyWith(height: 1.5),
                    ),
                    
                    const SizedBox(height: 100), // Space for FAB
                  ],
                ),
              ),
            ),
          ),
          
          // Bottom Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundLight,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      widget.price,
                      style: AppTheme.displayMedium.copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        shadowColor: AppTheme.primaryColor.withOpacity(0.4),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildPlanChip(String name, String price) {
    bool isSelected = selectedPlan == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = name;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.textDark : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade200,
          ),
        ),
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                color: isSelected ? Colors.white : AppTheme.textDark,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                color: isSelected ? Colors.white.withOpacity(0.8) : AppTheme.textGrey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: AppTheme.textDark),
    );
  }
}
