import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';
import '../services/favorites_manager.dart';
import 'details_screen.dart';

class SearchData {
  final String title;
  final String subtitle;
  final String price;
  final String originalPrice;
  final String category;
  final IconData icon;
  final Color color;
  final double rating;

  SearchData({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.originalPrice,
    required this.category,
    required this.icon,
    required this.color,
    required this.rating,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _searchHistory = [];
  final FavoritesManager _favoritesManager = FavoritesManager();
  String _selectedCategory = 'All';
  String _searchQuery = '';

  // All available services
  final List<SearchData> _allServices = [
    SearchData(
      title: 'Deep Cleaning',
      subtitle: 'Complete home deep cleaning service',
      price: '\$89',
      originalPrice: '\$120',
      category: 'Cleaning',
      icon: Icons.cleaning_services,
      color: AppTheme.neonBlue,
      rating: 4.9,
    ),
    SearchData(
      title: 'Kitchen Cleaning',
      subtitle: 'Deep clean for your kitchen',
      price: '\$80',
      originalPrice: '\$100',
      category: 'Cleaning',
      icon: Icons.kitchen,
      color: AppTheme.neonBlue,
      rating: 4.8,
    ),
    SearchData(
      title: 'Bathroom Cleaning',
      subtitle: 'Sanitized & sparkling bathroom',
      price: '\$35',
      originalPrice: '\$50',
      category: 'Cleaning',
      icon: Icons.bathroom,
      color: AppTheme.neonBlue,
      rating: 4.7,
    ),
    SearchData(
      title: 'Car Washing',
      subtitle: 'Exterior & interior detailing',
      price: '\$40',
      originalPrice: '\$55',
      category: 'Cleaning',
      icon: Icons.directions_car,
      color: AppTheme.neonBlue,
      rating: 4.6,
    ),
    SearchData(
      title: 'Sofa & Carpet Cleaning',
      subtitle: 'Remove stains & odors',
      price: '\$60',
      originalPrice: '\$85',
      category: 'Cleaning',
      icon: Icons.weekend,
      color: AppTheme.neonBlue,
      rating: 4.8,
    ),
    SearchData(
      title: 'Pipe Repair',
      subtitle: 'Fix leaks and pipe issues',
      price: '\$75',
      originalPrice: '\$95',
      category: 'Plumbing',
      icon: Icons.plumbing,
      color: AppTheme.neonGreen,
      rating: 4.8,
    ),
    SearchData(
      title: 'Drain Cleaning',
      subtitle: 'Unclog drains professionally',
      price: '\$50',
      originalPrice: '\$70',
      category: 'Plumbing',
      icon: Icons.water_drop,
      color: AppTheme.neonGreen,
      rating: 4.7,
    ),
    SearchData(
      title: 'Water Heater Service',
      subtitle: 'Installation & repair',
      price: '\$120',
      originalPrice: '\$150',
      category: 'Plumbing',
      icon: Icons.hot_tub,
      color: AppTheme.neonGreen,
      rating: 4.9,
    ),
    SearchData(
      title: 'Wiring Installation',
      subtitle: 'Safe electrical wiring',
      price: '\$100',
      originalPrice: '\$130',
      category: 'Electrician',
      icon: Icons.electrical_services,
      color: AppTheme.goldAccent,
      rating: 5.0,
    ),
    SearchData(
      title: 'Light Fixture Setup',
      subtitle: 'Install lights & fixtures',
      price: '\$45',
      originalPrice: '\$60',
      category: 'Electrician',
      icon: Icons.lightbulb,
      color: AppTheme.goldAccent,
      rating: 4.8,
    ),
    SearchData(
      title: 'Circuit Breaker Repair',
      subtitle: 'Fix electrical issues',
      price: '\$85',
      originalPrice: '\$110',
      category: 'Electrician',
      icon: Icons.power,
      color: AppTheme.goldAccent,
      rating: 4.9,
    ),
    SearchData(
      title: 'AC Repair & Service',
      subtitle: 'Complete AC maintenance',
      price: '\$120',
      originalPrice: '\$160',
      category: 'AC Service',
      icon: Icons.ac_unit,
      color: AppTheme.neonPurple,
      rating: 5.0,
    ),
    SearchData(
      title: 'AC Installation',
      subtitle: 'New AC unit installation',
      price: '\$200',
      originalPrice: '\$250',
      category: 'AC Service',
      icon: Icons.hvac,
      color: AppTheme.neonPurple,
      rating: 4.9,
    ),
    SearchData(
      title: 'Interior Painting',
      subtitle: 'Professional wall painting',
      price: '\$150',
      originalPrice: '\$200',
      category: 'Painting',
      icon: Icons.format_paint,
      color: Colors.pinkAccent,
      rating: 4.8,
    ),
    SearchData(
      title: 'Exterior Painting',
      subtitle: 'Weatherproof exterior paint',
      price: '\$180',
      originalPrice: '\$230',
      category: 'Painting',
      icon: Icons.home,
      color: Colors.pinkAccent,
      rating: 4.7,
    ),
  ];

  final List<String> _categories = [
    'All',
    'Cleaning',
    'Plumbing',
    'Electrician',
    'AC Service',
    'Painting',
  ];

  final List<String> _popularSearches = [
    'Deep Cleaning',
    'AC Repair',
    'Plumbing',
    'Electrical',
    'Painting',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SearchData> get _filteredServices {
    var services = _allServices;

    // Filter by category
    if (_selectedCategory != 'All') {
      services = services
          .where((service) => service.category == _selectedCategory)
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      services = services.where((service) {
        final titleMatch =
            service.title.toLowerCase().contains(_searchQuery.toLowerCase());
        final subtitleMatch = service.subtitle
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
        final categoryMatch = service.category
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
        return titleMatch || subtitleMatch || categoryMatch;
      }).toList();
    }

    return services;
  }

  void _addToSearchHistory(String query) {
    if (query.isEmpty) return;
    setState(() {
      _searchHistory.remove(query);
      _searchHistory.insert(0, query);
      if (_searchHistory.length > 5) {
        _searchHistory.removeLast();
      }
    });
  }

  void _removeFromSearchHistory(String query) {
    setState(() {
      _searchHistory.remove(query);
    });
  }

  void _performSearch(String query) {
    _searchController.text = query;
    _addToSearchHistory(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: PremiumBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header with Search Bar
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
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
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.neonBlue.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: Colors.white54,
                                  size: 22,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    autofocus: true,
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
                                if (_searchQuery.isNotEmpty)
                                  GestureDetector(
                                    onTap: () {
                                      _searchController.clear();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white54,
                                      size: 20,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2),
                    const SizedBox(height: 20),
                    // Category Filters
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          final isSelected = category == _selectedCategory;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                gradient: isSelected
                                    ? AppTheme.neonGradient
                                    : null,
                                color: isSelected
                                    ? null
                                    : Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.transparent
                                      : Colors.white.withOpacity(0.1),
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: AppTheme.neonPurple
                                              .withOpacity(0.3),
                                          blurRadius: 15,
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Text(
                                category,
                                style: AppTheme.bodyMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 100.ms)
                        .slideX(begin: 0.2),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: _searchQuery.isEmpty
                    ? _buildEmptySearchState()
                    : _buildSearchResults(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptySearchState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          if (_searchHistory.isNotEmpty) ...[
            Text(
              'Recent Searches',
              style: AppTheme.displayMedium.copyWith(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 15),
            ...List.generate(
              _searchHistory.length,
              (index) {
                final query = _searchHistory[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.history,
                              color: AppTheme.neonBlue,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _performSearch(query),
                                child: Text(
                                  query,
                                  style: AppTheme.bodyMedium.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _removeFromSearchHistory(query),
                              child: Icon(
                                Icons.close,
                                color: Colors.white38,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: (250 + index * 50).ms)
                    .slideX(begin: -0.2);
              },
            ),
            const SizedBox(height: 30),
          ],

          // Popular Searches
          Text(
            'Popular Searches',
            style: AppTheme.displayMedium.copyWith(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _popularSearches.map((search) {
              return GestureDetector(
                onTap: () => _performSearch(search),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.neonPurple.withOpacity(0.2),
                        AppTheme.neonBlue.withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.neonPurple.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: AppTheme.neonPurple,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        search,
                        style: AppTheme.bodyMedium.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_filteredServices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
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
                Icons.search_off,
                size: 80,
                color: Colors.white38,
              ),
            ).animate().scale(duration: 500.ms),
            const SizedBox(height: 20),
            Text(
              'No services found',
              style: AppTheme.displayMedium.copyWith(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 8),
            Text(
              'Try searching with different keywords',
              style: AppTheme.bodyMedium.copyWith(
                color: Colors.white60,
              ),
            ).animate().fadeIn(delay: 300.ms),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: _filteredServices.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final service = _filteredServices[index];
        return GestureDetector(
          onTap: () {
            _addToSearchHistory(service.title);
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
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: service.color.withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: service.color.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            service.color.withOpacity(0.3),
                            service.color.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: service.color.withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        service.icon,
                        color: service.color,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.title,
                            style: AppTheme.bodyLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            service.subtitle,
                            style: AppTheme.bodySmall.copyWith(
                              color: Colors.white60,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppTheme.goldAccent,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                service.rating.toString(),
                                style: AppTheme.bodySmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: service.color.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  service.category,
                                  style: AppTheme.bodySmall.copyWith(
                                    color: service.color,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ListenableBuilder(
                          listenable: _favoritesManager,
                          builder: (context, _) {
                            final isFavorite = _favoritesManager.isFavorite(service.title);
                            return GestureDetector(
                              onTap: () {
                                final favoriteService = FavoriteService(
                                  id: service.title,
                                  title: service.title,
                                  subtitle: service.subtitle,
                                  price: service.price,
                                  originalPrice: service.originalPrice,
                                  category: service.category,
                                  iconName: service.icon.toString().split('(').last.split(')').first.split('.').last,
                                  colorHex: '#${service.color.value.toRadixString(16).substring(2)}',
                                  rating: service.rating,
                                );
                                _favoritesManager.toggleFavorite(favoriteService);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isFavorite
                                      ? Colors.red.withOpacity(0.2)
                                      : Colors.white.withOpacity(0.05),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.white54,
                                  size: 20,
                                ),
                              ),
                            ).animate(
                              target: isFavorite ? 1 : 0,
                            ).scale(
                              duration: 200.ms,
                              begin: const Offset(1, 1),
                              end: const Offset(1.2, 1.2),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        Text(
                          service.price,
                          style: AppTheme.bodyLarge.copyWith(
                            color: AppTheme.neonGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          service.originalPrice,
                          style: AppTheme.bodySmall.copyWith(
                            color: Colors.white38,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(delay: (index * 50).ms)
            .slideX(begin: 0.2);
      },
    );
  }
}
