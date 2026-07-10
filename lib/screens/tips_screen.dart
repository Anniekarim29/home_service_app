import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _tips = const [
    {
      'title': 'HVAC Filter Replacement',
      'description': 'Replace your HVAC filters every 1-3 months to maintain air quality and efficiency.',
      'icon': Icons.air_outlined,
      'color': AppTheme.neonBlue,
    },
    {
      'title': 'Plumbing Leak Check',
      'description': 'Inspect under sinks for leaks and check water pressure regularly to prevent pipe bursts.',
      'icon': Icons.water_drop_outlined,
      'color': AppTheme.neonGreen,
    },
    {
      'title': 'Deep Cleaning Habits',
      'description': 'Schedule a deep clean for carpets and upholstery twice a year to prolong their lifespan.',
      'icon': Icons.cleaning_services_outlined,
      'color': AppTheme.neonPurple,
    },
    {
      'title': 'Electrical Safety',
      'description': 'Test your smoke detectors monthly and avoid overloading power outlets.',
      'icon': Icons.electrical_services_outlined,
      'color': AppTheme.goldAccent,
    },
    {
      'title': 'Lawn Care Timing',
      'description': 'Water your lawn early in the morning to minimize evaporation and fungal growth.',
      'icon': Icons.grass_outlined,
      'color': Colors.greenAccent,
    },
  ];

  List<Map<String, dynamic>> get _filteredTips {
    if (_searchQuery.isEmpty) {
      return _tips;
    }
    return _tips.where((tip) {
      final title = tip['title'].toString().toLowerCase();
      final desc = tip['description'].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();
      return title.contains(query) || desc.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: PremiumBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Home Tips',
                      style: AppTheme.displayMedium.copyWith(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideX(),

              // Search Bar
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search tips...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                      prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.5)),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.white54),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 100.ms),

              // Tips List
              Expanded(
                child: _filteredTips.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              size: 64,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No tips found for "$_searchQuery"',
                              style: AppTheme.bodyLarge.copyWith(color: Colors.white54),
                            ),
                          ],
                        ).animate().fadeIn(),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        itemCount: _filteredTips.length,
                        itemBuilder: (context, index) {
                          final tip = _filteredTips[index];
                          return _buildTipCard(tip, index);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard(Map<String, dynamic> tip, int index) {
    return Container(
      key: ValueKey(tip['title']),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: tip['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: tip['color'].withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: tip['color'].withOpacity(0.2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(tip['icon'], color: tip['color'], size: 28),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip['title'],
                  style: AppTheme.displayMedium.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tip['description'],
                  style: AppTheme.bodyMedium.copyWith(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 50 * index)).slideY(begin: 0.1);
  }
}
