class ReferralData {
  final int totalReferrals;
  final double earnedRewards;
  final double pendingRewards;
  final String referralCode;

  ReferralData({
    required this.totalReferrals,
    required this.earnedRewards,
    required this.pendingRewards,
    required this.referralCode,
  });
}

class ReferralService {
  static final ReferralService _instance = ReferralService._internal();
  factory ReferralService() => _instance;
  ReferralService._internal();

  ReferralData getReferralData() {
    // In a real app, this would fetch data from a backend
    // Returning mock data for demonstration
    return ReferralData(
      totalReferrals: 12,
      earnedRewards: 45.0,
      pendingRewards: 15.0,
      referralCode: "ANNIE2025",
    );
  }

  List<Map<String, dynamic>> getReferralHistory() {
    return [
      {
        'name': 'Sarah Johnson',
        'status': 'Completed',
        'reward': '\$10.00',
        'date': '2025-11-20',
      },
      {
        'name': 'Michael Chen',
        'status': 'Pending',
        'reward': '\$5.00',
        'date': '2025-12-15',
      },
      {
        'name': 'Jessica Albe',
        'status': 'Completed',
        'reward': '\$10.00',
        'date': '2025-12-10',
      },
      {
        'name': 'David Miller',
        'status': 'Completed',
        'reward': '\$10.00',
        'date': '2025-11-05',
      },
    ];
  }

  void shareReferralCode() {
    // Simulated sharing logic
    print("Sharing referral code: ANNIE2025");
  }
}
