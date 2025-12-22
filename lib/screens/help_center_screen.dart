import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'How do I book a service?',
      'answer': 'You can book a service by selecting a category from the home screen, choosing a specific service, and then following the checkout process.',
      'isExpanded': false,
    },
    {
      'question': 'What payment methods are accepted?',
      'answer': 'We accept all major credit cards, debit cards, and digital wallets like Apple Pay and Google Pay.',
      'isExpanded': false,
    },
    {
      'question': 'Can I cancel my booking?',
      'answer': 'Yes, you can cancel your booking up to 24 hours before the scheduled time for a full refund. Visit the Bookings tab to manage your orders.',
      'isExpanded': false,
    },
    {
      'question': 'How do I contact my service provider?',
      'answer': 'Once a booking is confirmed, you can chat directly with your provider through the Chat tab in the app.',
      'isExpanded': false,
    },
    {
      'question': 'Are the service providers verified?',
      'answer': 'Yes, all our service providers undergo a rigorous background check and verification process to ensure your safety and quality of service.',
      'isExpanded': false,
    },
  ];

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
                      'Help Center',
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
                      // Search Bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceDark,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            icon: Icon(Icons.search, color: Colors.white.withOpacity(0.5)),
                            hintText: 'Search for questions...',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                            border: InputBorder.none,
                          ),
                        ),
                      ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),

                      const SizedBox(height: 30),

                      // FAQ Section
                      Text(
                        'Frequently Asked Questions',
                        style: AppTheme.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ).animate().fadeIn(delay: 200.ms),

                      const SizedBox(height: 15),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _faqs.length,
                        itemBuilder: (context, index) {
                          final faq = _faqs[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceDark,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: faq['isExpanded']
                                    ? AppTheme.neonPurple.withOpacity(0.3)
                                    : Colors.white.withOpacity(0.05),
                              ),
                            ),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                onExpansionChanged: (value) {
                                  setState(() {
                                    faq['isExpanded'] = value;
                                  });
                                },
                                leading: Icon(
                                  Icons.help_outline,
                                  color: faq['isExpanded'] ? AppTheme.neonPurple : Colors.white.withOpacity(0.5),
                                ),
                                title: Text(
                                  faq['question'],
                                  style: AppTheme.bodyMedium.copyWith(
                                    color: Colors.white,
                                    fontWeight: faq['isExpanded'] ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                                trailing: Icon(
                                  faq['isExpanded'] ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                    child: Text(
                                      faq['answer'],
                                      style: AppTheme.bodySmall.copyWith(
                                        color: Colors.white.withOpacity(0.7),
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),

                      const SizedBox(height: 30),

                      // Contact Support Section
                      Text(
                        'Still need help?',
                        style: AppTheme.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ).animate().fadeIn(delay: 400.ms),

                      const SizedBox(height: 15),

                      _buildContactCard(
                        'Chat with Support',
                        'Average response time: 5 mins',
                        Icons.chat_bubble_outline,
                        AppTheme.neonBlue,
                      ),
                      const SizedBox(height: 12),
                      _buildContactCard(
                        'Email Us',
                        'support@homeservice.com',
                        Icons.mail_outline,
                        AppTheme.neonGreen,
                      ),
                      const SizedBox(height: 12),
                      _buildContactCard(
                        'Call Us',
                        '+1 (800) 123-4567',
                        Icons.phone_outlined,
                        AppTheme.goldAccent,
                      ),

                      const SizedBox(height: 30),
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

  Widget _buildContactCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTheme.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.2), size: 16),
        ],
      ),
    );
  }
}
