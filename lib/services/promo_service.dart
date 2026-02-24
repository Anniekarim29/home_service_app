import 'package:flutter/foundation.dart';

/// Model for a coupon
class Coupon {
  final String code;
  final String title;
  final String description;
  final double discount;
  final String expiryDate;
  final String icon;

  Coupon({
    required this.code,
    required this.title,
    required this.description,
    required this.discount,
    required this.expiryDate,
    required this.icon,
  });
}

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
    'HOME50': 0.50,
    'CLEAN25': 0.25,
  };

  /// Returns a list of available coupons for the user
  List<Coupon> getAvailableCoupons() {
    return [
      Coupon(
        code: 'WELCOME20',
        title: 'Welcome Discount',
        description: 'Get 20% off on your first service booking.',
        discount: 0.20,
        expiryDate: '31 Dec 2026',
        icon: '🎉',
      ),
      Coupon(
        code: 'SAVE10',
        title: 'Weekly Saver',
        description: 'Save 10% on any home maintenance service.',
        discount: 0.10,
        expiryDate: '15 Mar 2026',
        icon: '💰',
      ),
      Coupon(
        code: 'HOME50',
        title: 'Premium Home Care',
        description: 'Massive 50% discount for premium members.',
        discount: 0.50,
        expiryDate: '01 Jan 2026',
        icon: '🏠',
      ),
      Coupon(
        code: 'CLEAN25',
        title: 'Spring Cleaning',
        description: 'Special 25% off on all cleaning services.',
        discount: 0.25,
        expiryDate: '30 Apr 2026',
        icon: '✨',
      ),
    ];
  }

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

