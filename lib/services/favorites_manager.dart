import 'package:flutter/foundation.dart';

class FavoriteService {
  final String id;
  final String title;
  final String subtitle;
  final String price;
  final String originalPrice;
  final String category;
  final String iconName;
  final String colorHex;
  final double rating;

  FavoriteService({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.originalPrice,
    required this.category,
    required this.iconName,
    required this.colorHex,
    required this.rating,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'price': price,
        'originalPrice': originalPrice,
        'category': category,
        'iconName': iconName,
        'colorHex': colorHex,
        'rating': rating,
      };

  factory FavoriteService.fromJson(Map<String, dynamic> json) {
    return FavoriteService(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      price: json['price'],
      originalPrice: json['originalPrice'],
      category: json['category'],
      iconName: json['iconName'],
      colorHex: json['colorHex'],
      rating: json['rating'],
    );
  }
}

class FavoritesManager extends ChangeNotifier {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final List<FavoriteService> _favorites = [];

  List<FavoriteService> get favorites => List.unmodifiable(_favorites);

  int get favoritesCount => _favorites.length;

  bool isFavorite(String serviceId) {
    return _favorites.any((service) => service.id == serviceId);
  }

  void addFavorite(FavoriteService service) {
    if (!isFavorite(service.id)) {
      _favorites.add(service);
      notifyListeners();
    }
  }

  void removeFavorite(String serviceId) {
    _favorites.removeWhere((service) => service.id == serviceId);
    notifyListeners();
  }

  void toggleFavorite(FavoriteService service) {
    if (isFavorite(service.id)) {
      removeFavorite(service.id);
    } else {
      addFavorite(service);
    }
  }

  void clearAll() {
    _favorites.clear();
    notifyListeners();
  }
}
