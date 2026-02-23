import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();

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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'App Feedback',
                      style: AppTheme.displayMedium.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideX(),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'How was your experience?',
                        style: AppTheme.displayMedium.copyWith(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ).animate().fadeIn(delay: 100.ms),
                      const SizedBox(height: 10),
                      Text(
                        'Your feedback helps us improve our services for everyone.',
                        style: AppTheme.bodyMedium.copyWith(
                          color: Colors.white70,
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                      
                      const SizedBox(height: 40),

                      // Star Rating
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () => setState(() => _rating = index + 1),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(
                                  index < _rating ? Icons.star : Icons.star_border,
                                  color: index < _rating ? AppTheme.goldAccent : Colors.white24,
                                  size: 45,
                                ).animate(target: index < _rating ? 1 : 0)
                                .scale(duration: 200.ms, begin: const Offset(1, 1), end: const Offset(1.2, 1.2))
                                .shimmer(duration: 1000.ms, color: Colors.white54, isEnabled: index < _rating),
                              ),
                            );
                          }),
                        ),
                      ).animate().fadeIn(delay: 300.ms).scale(),

                      const SizedBox(height: 40),

                      // Feedback Input
                      Text(
                        'Tell us more (Optional)',
                        style: AppTheme.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ).animate().fadeIn(delay: 400.ms),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: TextField(
                          controller: _feedbackController,
                          maxLines: 5,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Share your thoughts, suggestions or issues...',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                            border: InputBorder.none,
                          ),
                        ),
                      ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),

                      const SizedBox(height: 40),

                      // Submit Button
                      ElevatedButton(
                        onPressed: _rating == 0 ? null : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Thank you for your feedback!'),
                              backgroundColor: AppTheme.neonGreen,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.neonPurple,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 10,
                          shadowColor: AppTheme.neonPurple.withOpacity(0.5),
                          disabledBackgroundColor: AppTheme.surfaceDark,
                        ),
                        child: const Text(
                          'Submit Feedback',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
