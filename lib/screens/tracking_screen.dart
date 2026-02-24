import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'chat_screen.dart';

class TrackingScreen extends StatefulWidget {
  final String serviceName;
  final String providerName;
  final String providerImage;
  final String eta;

  const TrackingScreen({
    super.key,
    this.serviceName = 'Home Cleaning',
    this.providerName = 'Marcus Johnson',
    this.providerImage = 'assets/images/profile.jpeg',
    this.eta = '12 min',
  });

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _progressController;

  int _currentStep = 1; // 0=Confirmed, 1=On the Way, 2=Arrived, 3=In Progress, 4=Done
  Timer? _demoTimer;

  final List<_TrackingStep> _steps = [
    _TrackingStep(
      icon: Icons.check_circle_rounded,
      title: 'Booking Confirmed',
      subtitle: 'Your booking has been confirmed',
      time: '10:00 AM',
    ),
    _TrackingStep(
      icon: Icons.directions_car_rounded,
      title: 'Provider On the Way',
      subtitle: 'Marcus is heading to your location',
      time: '10:05 AM',
    ),
    _TrackingStep(
      icon: Icons.location_on_rounded,
      title: 'Provider Arrived',
      subtitle: 'Marcus has arrived at your door',
      time: '--',
    ),
    _TrackingStep(
      icon: Icons.home_repair_service_rounded,
      title: 'Service In Progress',
      subtitle: 'Work is underway',
      time: '--',
    ),
    _TrackingStep(
      icon: Icons.star_rounded,
      title: 'Service Completed',
      subtitle: 'All done! Please leave a review',
      time: '--',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    // Auto-advance steps every 4 seconds for demo
    _demoTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_currentStep < _steps.length - 1) {
        setState(() {
          _currentStep++;
          _steps[_currentStep].time = _formattedNow();
        });
        _progressController.forward(from: 0);
      } else {
        _demoTimer?.cancel();
      }
    });
  }

  String _formattedNow() {
    final now = DateTime.now();
    final h = now.hour > 12 ? now.hour - 12 : now.hour;
    final m = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $period';
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _progressController.dispose();
    _demoTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: Stack(
        children: [
          // Gradient background blobs
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.neonBlue.withOpacity(0.25),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.neonPurple.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // === APP BAR ===
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_rounded,
                              color: Colors.white, size: 18),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Live Tracking',
                              style: AppTheme.displayMedium.copyWith(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.serviceName,
                              style: AppTheme.bodySmall.copyWith(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ETA badge
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (_, __) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.neonBlue,
                                AppTheme.neonPurple,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.neonBlue.withOpacity(
                                  0.3 + 0.2 * _pulseController.value,
                                ),
                                blurRadius: 14,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.timer_outlined, color: Colors.white, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                _currentStep >= 2 ? 'Arrived!' : widget.eta,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),

                // === PROVIDER CARD ===
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.neonBlue.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppTheme.neonGradient,
                              ),
                              child: CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage(widget.providerImage),
                              ),
                            ),
                            Positioned(
                              right: 2,
                              bottom: 2,
                              child: AnimatedBuilder(
                                animation: _pulseController,
                                builder: (_, __) => Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: AppTheme.neonGreen,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppTheme.backgroundDark,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.neonGreen.withOpacity(
                                          0.5 + 0.4 * _pulseController.value,
                                        ),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.providerName,
                                style: AppTheme.bodyLarge.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    '4.9  •  ${widget.serviceName}',
                                    style: AppTheme.bodySmall.copyWith(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Chat button
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChatScreen(),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: AppTheme.neonGradient,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.neonPurple.withOpacity(0.4),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.chat_bubble_outline_rounded,
                                color: Colors.white, size: 18),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Call button
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Calling provider...'),
                                backgroundColor: AppTheme.neonGreen,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.neonGreen.withOpacity(0.15),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppTheme.neonGreen.withOpacity(0.4),
                              ),
                            ),
                            child: Icon(Icons.call_rounded,
                                color: AppTheme.neonGreen, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.2),

                const SizedBox(height: 24),

                // === LIVE MAP PLACEHOLDER ===
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF1A2535),
                            const Color(0xFF0D1B2A),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: Colors.white.withOpacity(0.08)),
                      ),
                      child: Stack(
                        children: [
                          // Grid lines (map style)
                          ...List.generate(5, (i) => Positioned(
                            top: i * 34.0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 1,
                              color: Colors.white.withOpacity(0.04),
                            ),
                          )),
                          ...List.generate(7, (i) => Positioned(
                            left: i * 48.0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width: 1,
                              color: Colors.white.withOpacity(0.04),
                            ),
                          )),
                          // Roads
                          Positioned(
                            top: 80,
                            left: 0,
                            right: 0,
                            child: Container(height: 5, color: Colors.white.withOpacity(0.06)),
                          ),
                          Positioned(
                            left: 130,
                            top: 0,
                            bottom: 0,
                            child: Container(width: 5, color: Colors.white.withOpacity(0.06)),
                          ),
                          // Route line
                          CustomPaint(
                            size: const Size(double.infinity, 170),
                            painter: _RoutePainter(
                              progress: _progressController.value,
                              color: AppTheme.neonBlue,
                            ),
                          ),
                          // Provider marker (animated)
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOut,
                            left: _currentStep >= 2 ? 200 : 80 + _currentStep * 40.0,
                            top: _currentStep >= 2 ? 65 : 50 + _currentStep * 10.0,
                            child: AnimatedBuilder(
                              animation: _pulseController,
                              builder: (_, child) => Transform.scale(
                                scale: 1.0 + 0.1 * _pulseController.value,
                                child: child,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: AppTheme.neonGradient,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.neonBlue.withOpacity(0.6),
                                          blurRadius: 14,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(Icons.directions_car_rounded,
                                        color: Colors.white, size: 18),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 8,
                                    color: AppTheme.neonBlue.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Destination pin
                          const Positioned(
                            right: 40,
                            top: 55,
                            child: Icon(Icons.location_on_rounded,
                                color: Colors.red, size: 32),
                          ),
                          // Map label
                          Positioned(
                            bottom: 12,
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AnimatedBuilder(
                                    animation: _pulseController,
                                    builder: (_, __) => Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppTheme.neonGreen,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppTheme.neonGreen.withOpacity(
                                              0.4 + 0.4 * _pulseController.value,
                                            ),
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Live Location',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 250.ms).scale(begin: const Offset(0.95, 0.95)),

                const SizedBox(height: 24),

                // === STEP TRACKER ===
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status Updates',
                          style: AppTheme.displayMedium.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ).animate().fadeIn(delay: 350.ms),
                        const SizedBox(height: 14),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _steps.length,
                            itemBuilder: (context, i) {
                              final isDone = i <= _currentStep;
                              final isActive = i == _currentStep;
                              return _buildStepItem(i, isDone, isActive);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // === BOTTOM: Cancel Button ===
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red.withOpacity(0.6)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Cancel Booking',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Support team contacted!'),
                                backgroundColor: AppTheme.neonBlue,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.neonBlue,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Get Support',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(int index, bool isDone, bool isActive) {
    final step = _steps[index];
    final isLast = index == _steps.length - 1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isDone ? AppTheme.neonGradient : null,
                color: isDone ? null : Colors.white.withOpacity(0.06),
                border: Border.all(
                  color: isDone
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.12),
                  width: 1.5,
                ),
                boxShadow: isDone
                    ? [
                        BoxShadow(
                          color: AppTheme.neonBlue.withOpacity(0.4),
                          blurRadius: 12,
                        ),
                      ]
                    : [],
              ),
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (_, __) => Icon(
                  step.icon,
                  color: isDone ? Colors.white : Colors.white24,
                  size: isActive ? 20 + _pulseController.value * 2 : 18,
                ),
              ),
            ),
            if (!isLast)
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 2,
                height: 50,
                decoration: BoxDecoration(
                  gradient: isDone && index < _currentStep
                      ? LinearGradient(
                          colors: [AppTheme.neonBlue, AppTheme.neonPurple],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      : null,
                  color: isDone && index < _currentStep
                      ? null
                      : Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 10),
            child: AnimatedOpacity(
              opacity: isDone ? 1.0 : 0.35,
              duration: const Duration(milliseconds: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        step.title,
                        style: AppTheme.bodyLarge.copyWith(
                          color: isActive ? Colors.white : Colors.white70,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        step.time,
                        style: AppTheme.bodySmall.copyWith(
                          color: isDone ? AppTheme.neonBlue : Colors.white24,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    step.subtitle,
                    style: AppTheme.bodySmall.copyWith(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: (400 + index * 80).ms).slideX(begin: 0.15);
  }
}

class _TrackingStep {
  final IconData icon;
  final String title;
  final String subtitle;
  String time;

  _TrackingStep({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });
}

class _RoutePainter extends CustomPainter {
  final double progress;
  final Color color;

  _RoutePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.6)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(60, 60);
    path.cubicTo(100, 60, 120, 100, 160, 90);
    path.cubicTo(190, 82, 210, 65, 255, 68);

    final metrics = path.computeMetrics().first;
    final extractPath = metrics.extractPath(0, metrics.length * progress);
    canvas.drawPath(extractPath, paint);

    // Dots along the route
    final dotPaint = Paint()..color = color.withOpacity(0.3);
    for (int i = 0; i < 4; i++) {
      canvas.drawCircle(
        Offset(80 + i * 55.0, 74 - i * 4.0),
        3,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_RoutePainter oldDelegate) => oldDelegate.progress != progress;
}
