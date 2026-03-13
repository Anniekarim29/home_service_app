import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// Service for managing push notification preferences and state
class PushNotificationService extends ChangeNotifier {
  // Singleton pattern
  static final PushNotificationService _instance = PushNotificationService._internal();
  factory PushNotificationService() => _instance;
  PushNotificationService._internal();

  // Master notification toggle
  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  // Category-specific toggles
  bool _bookingNotifications = true;
  bool _offerNotifications = true;
  bool _paymentNotifications = true;
  bool _systemNotifications = true;

  bool get bookingNotifications => _bookingNotifications;
  bool get offerNotifications => _offerNotifications;
  bool get paymentNotifications => _paymentNotifications;
  bool get systemNotifications => _systemNotifications;

  // Do Not Disturb settings
  bool _dndEnabled = false;
  TimeOfDay _dndStartTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _dndEndTime = const TimeOfDay(hour: 7, minute: 0);

  bool get dndEnabled => _dndEnabled;
  TimeOfDay get dndStartTime => _dndStartTime;
  TimeOfDay get dndEndTime => _dndEndTime;

  /// Toggle master notifications
  void setNotificationsEnabled(bool enabled) {
    _notificationsEnabled = enabled;
    notifyListeners();
  }

  /// Toggle booking notifications
  void setBookingNotifications(bool enabled) {
    _bookingNotifications = enabled;
    notifyListeners();
  }

  /// Toggle offer notifications
  void setOfferNotifications(bool enabled) {
    _offerNotifications = enabled;
    notifyListeners();
  }

  /// Toggle payment notifications
  void setPaymentNotifications(bool enabled) {
    _paymentNotifications = enabled;
    notifyListeners();
  }

  /// Toggle system notifications
  void setSystemNotifications(bool enabled) {
    _systemNotifications = enabled;
    notifyListeners();
  }

  /// Toggle Do Not Disturb
  void setDndEnabled(bool enabled) {
    _dndEnabled = enabled;
    notifyListeners();
  }

  /// Set DND start time
  void setDndStartTime(TimeOfDay time) {
    _dndStartTime = time;
    notifyListeners();
  }

  /// Set DND end time
  void setDndEndTime(TimeOfDay time) {
    _dndEndTime = time;
    notifyListeners();
  }

  /// Check if notifications should be sent based on current preferences
  bool shouldSendNotification(String category) {
    // Check master toggle
    if (!_notificationsEnabled) return false;

    // Check DND
    if (_dndEnabled && _isInDndPeriod()) return false;

    // Check category-specific toggle
    switch (category.toLowerCase()) {
      case 'booking':
        return _bookingNotifications;
      case 'offer':
        return _offerNotifications;
      case 'payment':
        return _paymentNotifications;
      case 'system':
        return _systemNotifications;
      default:
        return true;
    }
  }

  /// Check if current time is within DND period
  bool _isInDndPeriod() {
    final now = TimeOfDay.now();
    final nowMinutes = now.hour * 60 + now.minute;
    final startMinutes = _dndStartTime.hour * 60 + _dndStartTime.minute;
    final endMinutes = _dndEndTime.hour * 60 + _dndEndTime.minute;

    if (startMinutes < endMinutes) {
      // DND period doesn't cross midnight
      return nowMinutes >= startMinutes && nowMinutes < endMinutes;
    } else {
      // DND period crosses midnight
      return nowMinutes >= startMinutes || nowMinutes < endMinutes;
    }
  }
}
