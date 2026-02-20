import 'package:flutter/foundation.dart';

/// Service for managing and validating promo codes
class PromoService {
  static final PromoService _instance = PromoService._internal();
  factory PromoService() => _instance;
  PromoService._internal();

  // Map of valid promo codes and their discount percentages
  final Map<String, double> _validCodes = {
    'SAVE10': 0.10, // 10% discount
    'WELCOME20': 0.20, // 20% discount
    'PROMO50': 0.50, // 50% discount
    'ANNIE': 1.0, // 100% discount (Special)
  };

  /// Validates a promo code and returns the discount multiplier (0.0 to 1.0)
  /// Returns null if the code is invalid.
  double? validateCode(String code) {
    final normalizedCode = code.trim().toUpperCase();
    if (_validCodes.containsKey(normalizedCode)) {
      return _validCodes[normalizedCode];
    }
    return null;
  }

  /// Calculates discount amount
  double calculateDiscount(double basePrice, double percentage) {
    return basePrice * percentage;
  }
}
