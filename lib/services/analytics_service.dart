class ServiceUsageData {
  final String serviceId;
  final String serviceName;
  final String category;
  final double amount;
  final DateTime date;

  ServiceUsageData({
    required this.serviceId,
    required this.serviceName,
    required this.category,
    required this.amount,
    required this.date,
  });
}

class MonthlySpending {
  final String month;
  final double amount;
  final int serviceCount;

  MonthlySpending({
    required this.month,
    required this.amount,
    required this.serviceCount,
  });
}

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final List<ServiceUsageData> _usageHistory = [];

  // Initialize with sample data
  void initializeSampleData() {
    if (_usageHistory.isNotEmpty) return;

    final now = DateTime.now();
    _usageHistory.addAll([
      ServiceUsageData(
        serviceId: '1',
        serviceName: 'House Cleaning',
        category: 'Cleaning',
        amount: 75.00,
        date: now.subtract(const Duration(days: 5)),
      ),
      ServiceUsageData(
        serviceId: '2',
        serviceName: 'Plumbing Repair',
        category: 'Plumbing',
        amount: 120.00,
        date: now.subtract(const Duration(days: 12)),
      ),
      ServiceUsageData(
        serviceId: '3',
        serviceName: 'AC Maintenance',
        category: 'AC Repair',
        amount: 95.00,
        date: now.subtract(const Duration(days: 18)),
      ),
      ServiceUsageData(
        serviceId: '4',
        serviceName: 'Electrical Work',
        category: 'Electrical',
        amount: 150.00,
        date: now.subtract(const Duration(days: 25)),
      ),
      ServiceUsageData(
        serviceId: '5',
        serviceName: 'Deep Cleaning',
        category: 'Cleaning',
        amount: 120.00,
        date: now.subtract(const Duration(days: 35)),
      ),
      ServiceUsageData(
        serviceId: '6',
        serviceName: 'Painting',
        category: 'Painting',
        amount: 200.00,
        date: now.subtract(const Duration(days: 45)),
      ),
      ServiceUsageData(
        serviceId: '7',
        serviceName: 'Carpet Cleaning',
        category: 'Cleaning',
        amount: 85.00,
        date: now.subtract(const Duration(days: 60)),
      ),
    ]);
  }

  // Add new service usage
  void addServiceUsage(ServiceUsageData data) {
    _usageHistory.add(data);
  }

  // Get total spending
  double getTotalSpending() {
    return _usageHistory.fold(0.0, (sum, item) => sum + item.amount);
  }

  // Get spending for a specific period
  double getSpendingForPeriod(DateTime start, DateTime end) {
    return _usageHistory
        .where((item) => item.date.isAfter(start) && item.date.isBefore(end))
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  // Get current month spending
  double getCurrentMonthSpending() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);
    return getSpendingForPeriod(startOfMonth, endOfMonth);
  }

  // Get monthly spending breakdown (last 6 months)
  List<MonthlySpending> getMonthlySpending() {
    final now = DateTime.now();
    final monthlyData = <String, MonthlySpending>{};

    for (int i = 5; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1);
      final monthKey = '${_getMonthName(month.month)} ${month.year}';
      monthlyData[monthKey] = MonthlySpending(
        month: monthKey,
        amount: 0.0,
        serviceCount: 0,
      );
    }

    for (var usage in _usageHistory) {
      final monthKey = '${_getMonthName(usage.date.month)} ${usage.date.year}';
      if (monthlyData.containsKey(monthKey)) {
        final existing = monthlyData[monthKey]!;
        monthlyData[monthKey] = MonthlySpending(
          month: monthKey,
          amount: existing.amount + usage.amount,
          serviceCount: existing.serviceCount + 1,
        );
      }
    }

    return monthlyData.values.toList();
  }

  // Get category breakdown
  Map<String, double> getCategoryBreakdown() {
    final breakdown = <String, double>{};
    
    for (var usage in _usageHistory) {
      breakdown[usage.category] = (breakdown[usage.category] ?? 0.0) + usage.amount;
    }
    
    return breakdown;
  }

  // Get top services
  List<Map<String, dynamic>> getTopServices({int limit = 5}) {
    final serviceMap = <String, Map<String, dynamic>>{};
    
    for (var usage in _usageHistory) {
      if (serviceMap.containsKey(usage.serviceName)) {
        serviceMap[usage.serviceName]!['count'] += 1;
        serviceMap[usage.serviceName]!['totalSpent'] += usage.amount;
      } else {
        serviceMap[usage.serviceName] = {
          'name': usage.serviceName,
          'category': usage.category,
          'count': 1,
          'totalSpent': usage.amount,
        };
      }
    }
    
    final sortedServices = serviceMap.values.toList()
      ..sort((a, b) => (b['count'] as int).compareTo(a['count'] as int));
    
    return sortedServices.take(limit).toList();
  }

  // Get service count
  int getTotalServiceCount() {
    return _usageHistory.length;
  }

  // Get average spending per service
  double getAverageSpendingPerService() {
    if (_usageHistory.isEmpty) return 0.0;
    return getTotalSpending() / _usageHistory.length;
  }

  // Get savings (assuming 20% discount on average)
  double getTotalSavings() {
    return getTotalSpending() * 0.20;
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
