class RatingData {
  final String bookingId;
  final String serviceProviderId;
  final String serviceName;
  final double overallRating;
  final double qualityRating;
  final double punctualityRating;
  final double professionalismRating;
  final double valueRating;
  final String feedback;
  final List<String> photoUrls;
  final DateTime ratedAt;

  RatingData({
    required this.bookingId,
    required this.serviceProviderId,
    required this.serviceName,
    required this.overallRating,
    required this.qualityRating,
    required this.punctualityRating,
    required this.professionalismRating,
    required this.valueRating,
    required this.feedback,
    this.photoUrls = const [],
    required this.ratedAt,
  });
}

class RatingService {
  static final RatingService _instance = RatingService._internal();
  factory RatingService() => _instance;
  RatingService._internal();

  final Map<String, RatingData> _ratings = {};
  final Map<String, List<RatingData>> _providerRatings = {};

  // Submit a new rating
  Future<bool> submitRating(RatingData rating) async {
    try {
      _ratings[rating.bookingId] = rating;
      
      if (_providerRatings.containsKey(rating.serviceProviderId)) {
        _providerRatings[rating.serviceProviderId]!.add(rating);
      } else {
        _providerRatings[rating.serviceProviderId] = [rating];
      }
      
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get rating for a specific booking
  RatingData? getRatingForBooking(String bookingId) {
    return _ratings[bookingId];
  }

  // Check if booking has been rated
  bool hasRated(String bookingId) {
    return _ratings.containsKey(bookingId);
  }

  // Get all ratings for a provider
  List<RatingData> getProviderRatings(String providerId) {
    return _providerRatings[providerId] ?? [];
  }

  // Calculate average rating for a provider
  double getProviderAverageRating(String providerId) {
    final ratings = _providerRatings[providerId];
    if (ratings == null || ratings.isEmpty) return 0.0;
    
    final sum = ratings.fold<double>(
      0.0,
      (prev, rating) => prev + rating.overallRating,
    );
    
    return sum / ratings.length;
  }

  // Get all user ratings
  List<RatingData> getAllUserRatings() {
    return _ratings.values.toList()
      ..sort((a, b) => b.ratedAt.compareTo(a.ratedAt));
  }

  // Get rating statistics
  Map<String, dynamic> getRatingStats() {
    final allRatings = _ratings.values.toList();
    if (allRatings.isEmpty) {
      return {
        'totalRatings': 0,
        'averageRating': 0.0,
        'fiveStarCount': 0,
        'fourStarCount': 0,
        'threeStarCount': 0,
        'twoStarCount': 0,
        'oneStarCount': 0,
      };
    }

    int fiveStar = 0, fourStar = 0, threeStar = 0, twoStar = 0, oneStar = 0;
    double totalRating = 0.0;

    for (var rating in allRatings) {
      totalRating += rating.overallRating;
      if (rating.overallRating >= 4.5) {
        fiveStar++;
      } else if (rating.overallRating >= 3.5) {
        fourStar++;
      } else if (rating.overallRating >= 2.5) {
        threeStar++;
      } else if (rating.overallRating >= 1.5) {
        twoStar++;
      } else {
        oneStar++;
      }
    }

    return {
      'totalRatings': allRatings.length,
      'averageRating': totalRating / allRatings.length,
      'fiveStarCount': fiveStar,
      'fourStarCount': fourStar,
      'threeStarCount': threeStar,
      'twoStarCount': twoStar,
      'oneStarCount': oneStar,
    };
  }
}
