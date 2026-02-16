import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';
import '../services/push_notification_service.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  final _notificationService = PushNotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: PremiumBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white, size: 20),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Notification Preferences',
                      style: AppTheme.displayMedium.copyWith(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideX(),

              const SizedBox(height: 20),

              // Preferences List
              Expanded(
                child: ListenableBuilder(
                  listenable: _notificationService,
                  builder: (context, _) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          // Master Toggle Section
                          _buildSection(
                            'Master Control',
                            [
                              _buildSwitchTile(
                                Icons.notifications_active,
                                'Push Notifications',
                                'Enable or disable all notifications',
                                AppTheme.neonPurple,
                                _notificationService.notificationsEnabled,
                                (value) => _notificationService
                                    .setNotificationsEnabled(value),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // Categories Section
                          _buildSection(
                            'Notification Categories',
                            [
                              _buildSwitchTile(
                                Icons.calendar_today,
                                'Booking Updates',
                                'Confirmations, reminders, and changes',
                                AppTheme.neonBlue,
                                _notificationService.bookingNotifications,
                                (value) => _notificationService
                                    .setBookingNotifications(value),
                                enabled:
                                    _notificationService.notificationsEnabled,
                              ),
                              _buildSwitchTile(
                                Icons.local_offer,
                                'Special Offers',
                                'Discounts and promotional deals',
                                AppTheme.goldAccent,
                                _notificationService.offerNotifications,
                                (value) => _notificationService
                                    .setOfferNotifications(value),
                                enabled:
                                    _notificationService.notificationsEnabled,
                              ),
                              _buildSwitchTile(
                                Icons.payment,
                                'Payment Alerts',
                                'Transaction confirmations and receipts',
                                AppTheme.neonGreen,
                                _notificationService.paymentNotifications,
                                (value) => _notificationService
                                    .setPaymentNotifications(value),
                                enabled:
                                    _notificationService.notificationsEnabled,
                              ),
                              _buildSwitchTile(
                                Icons.system_update,
                                'System Updates',
                                'App updates and announcements',
                                AppTheme.neonPurple,
                                _notificationService.systemNotifications,
                                (value) => _notificationService
                                    .setSystemNotifications(value),
                                enabled:
                                    _notificationService.notificationsEnabled,
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // Do Not Disturb Section
                          _buildSection(
                            'Do Not Disturb',
                            [
                              _buildSwitchTile(
                                Icons.bedtime,
                                'Enable DND',
                                'Silence notifications during set hours',
                                Colors.deepPurple,
                                _notificationService.dndEnabled,
                                (value) =>
                                    _notificationService.setDndEnabled(value),
                                enabled:
                                    _notificationService.notificationsEnabled,
                              ),
                              if (_notificationService.dndEnabled &&
                                  _notificationService.notificationsEnabled)
                                _buildDndTimePicker(),
                            ],
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    );
                  },
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title,
            style: AppTheme.bodySmall.copyWith(
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    IconData icon,
    String title,
    String subtitle,
    Color iconColor,
    bool value,
    ValueChanged<bool> onChanged, {
    bool enabled = true,
  }) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.bodyLarge.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTheme.bodySmall.copyWith(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: value,
              onChanged: enabled ? onChanged : null,
              activeColor: iconColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDndTimePicker() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quiet Hours',
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTimeButton(
                  'Start',
                  _notificationService.dndStartTime,
                  (time) => _notificationService.setDndStartTime(time),
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.arrow_forward,
                  color: Colors.white.withOpacity(0.3), size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTimeButton(
                  'End',
                  _notificationService.dndEndTime,
                  (time) => _notificationService.setDndEndTime(time),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().scale();
  }

  Widget _buildTimeButton(
    String label,
    TimeOfDay time,
    ValueChanged<TimeOfDay> onTimeSelected,
  ) {
    return GestureDetector(
      onTap: () async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: time,
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: AppTheme.neonPurple,
                  onPrimary: Colors.white,
                  surface: AppTheme.surfaceDark,
                  onSurface: Colors.white,
                ),
                dialogBackgroundColor: AppTheme.surfaceDark,
              ),
              child: child!,
            );
          },
        );
        if (selectedTime != null) {
          onTimeSelected(selectedTime);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTheme.bodySmall.copyWith(
                color: Colors.white.withOpacity(0.5),
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time.format(context),
              style: AppTheme.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
