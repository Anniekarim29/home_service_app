import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';
import '../services/rating_service.dart';

class RateServiceScreen extends StatefulWidget {
  final String bookingId;
  final String serviceProviderId;
  final String serviceName;
  final String providerName;

  const RateServiceScreen({
    super.key,
    required this.bookingId,
    required this.serviceProviderId,
    required this.serviceName,
    required this.providerName,
  });

  @override
  State<RateServiceScreen> createState() => _RateServiceScreenState();
}

class _RateServiceScreenState extends State<RateServiceScreen> {
  double _overallRating = 0;
  double _qualityRating = 0;
  double _punctualityRating = 0;
  double _professionalismRating = 0;
  double _valueRating = 0;
  final TextEditingController _feedbackController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submitRating() async {
    if (_overallRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please provide an overall rating'),
          backgroundColor: Colors.red.shade900,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final rating = RatingData(
      bookingId: widget.bookingId,
      serviceProviderId: widget.serviceProviderId,
      serviceName: widget.serviceName,
      overallRating: _overallRating,
      qualityRating: _qualityRating,
      punctualityRating: _punctualityRating,
      professionalismRating: _professionalismRating,
      valueRating: _valueRating,
      feedback: _feedbackController.text,
      ratedAt: DateTime.now(),
    );

    final success = await RatingService().submitRating(rating);

    setState(() => _isSubmitting = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thank you for your feedback!'),
          backgroundColor: AppTheme.neonGreen,
        ),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PremiumBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildServiceInfo(),
                      const SizedBox(height: 30),
                      _buildOverallRating(),
                      const SizedBox(height: 30),
                      _buildCategoryRatings(),
                      const SizedBox(height: 30),
                      _buildFeedbackSection(),
                      const SizedBox(height: 30),
                      _buildSubmitButton(),
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

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.neonPurple.withOpacity(0.3),
                ),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Rate Service',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.neonBlue.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.serviceName,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: AppTheme.neonBlue,
              ),
              const SizedBox(width: 8),
              Text(
                widget.providerName,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverallRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overall Rating',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _overallRating = (index + 1).toDouble();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        index < _overallRating ? Icons.star : Icons.star_border,
                        size: 48,
                        color: index < _overallRating
                            ? AppTheme.goldAccent
                            : Colors.white30,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),
              if (_overallRating > 0)
                Text(
                  _getRatingText(_overallRating),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppTheme.goldAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryRatings() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.neonPurple.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detailed Ratings',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          _buildCategoryRatingRow('Quality', _qualityRating, (value) {
            setState(() => _qualityRating = value);
          }),
          const SizedBox(height: 16),
          _buildCategoryRatingRow('Punctuality', _punctualityRating, (value) {
            setState(() => _punctualityRating = value);
          }),
          const SizedBox(height: 16),
          _buildCategoryRatingRow('Professionalism', _professionalismRating, (value) {
            setState(() => _professionalismRating = value);
          }),
          const SizedBox(height: 16),
          _buildCategoryRatingRow('Value for Money', _valueRating, (value) {
            setState(() => _valueRating = value);
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryRatingRow(String label, double rating, Function(double) onRatingChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => onRatingChanged((index + 1).toDouble()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    size: 24,
                    color: index < rating
                        ? AppTheme.neonBlue
                        : Colors.white30,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Feedback',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.neonGreen.withOpacity(0.3),
            ),
          ),
          child: TextField(
            controller: _feedbackController,
            maxLines: 5,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: 'Share your experience with this service...',
              hintStyle: GoogleFonts.inter(
                color: Colors.white30,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : _submitRating,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: AppTheme.neonGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: _isSubmitting
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Submit Rating',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  String _getRatingText(double rating) {
    if (rating >= 4.5) return 'Excellent!';
    if (rating >= 3.5) return 'Good';
    if (rating >= 2.5) return 'Average';
    if (rating >= 1.5) return 'Below Average';
    return 'Poor';
  }
}
