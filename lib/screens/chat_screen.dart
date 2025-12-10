import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: PremiumBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Messages',
                      style: AppTheme.displayMedium.copyWith(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: AppTheme.neonGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.neonPurple.withOpacity(0.4),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.edit_note, color: Colors.white, size: 22),
                    ),
                  ],
                ).animate().fadeIn().slideX(),
                
                const SizedBox(height: 25),
                
                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search conversations...',
                      hintStyle: AppTheme.bodyMedium.copyWith(color: Colors.white38),
                      border: InputBorder.none,
                      icon: const Icon(Icons.search, color: Colors.white54),
                    ),
                  ),
                ).animate().fadeIn(delay: 100.ms),

                const SizedBox(height: 25),

                // Chat List
                Expanded(
                  child: ListView(
                    children: [
                      _buildChatTile(
                        'Support Team',
                        'Your booking has been confirmed! 🎉',
                        '2m ago',
                        true,
                        AppTheme.neonBlue,
                        3,
                        true,
                      ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                      
                      const SizedBox(height: 15),
                      
                      _buildChatTile(
                        'Sarah Johnson',
                        'I will be there in 10 minutes. See you soon!',
                        '1h ago',
                        true,
                        AppTheme.neonGreen,
                        1,
                        true,
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                      
                      const SizedBox(height: 15),
                      
                      _buildChatTile(
                        'Mike Anderson',
                        'The plumbing work is completed. Thank you!',
                        '3h ago',
                        false,
                        AppTheme.neonPurple,
                        0,
                        false,
                      ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                      
                      const SizedBox(height: 15),
                      
                      _buildChatTile(
                        'David Martinez',
                        'I\'ll bring all the necessary equipment.',
                        'Yesterday',
                        false,
                        AppTheme.goldAccent,
                        0,
                        false,
                      ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
                      
                      const SizedBox(height: 15),
                      
                      _buildChatTile(
                        'James Wilson',
                        'Thanks for the 5-star review! 😊',
                        '2 days ago',
                        false,
                        Colors.tealAccent,
                        0,
                        false,
                      ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
                      
                      const SizedBox(height: 100), // Bottom spacer
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatTile(
    String name,
    String message,
    String time,
    bool hasUnread,
    Color avatarColor,
    int unreadCount,
    bool isOnline,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: hasUnread 
              ? avatarColor.withOpacity(0.3) 
              : Colors.white.withOpacity(0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: hasUnread 
                ? avatarColor.withOpacity(0.15) 
                : Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar with Online Status
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: hasUnread 
                      ? LinearGradient(colors: [avatarColor, avatarColor.withOpacity(0.6)])
                      : null,
                  border: Border.all(
                    color: hasUnread ? avatarColor : Colors.white.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: avatarColor.withOpacity(0.2),
                  child: Text(
                    name[0],
                    style: TextStyle(
                      color: avatarColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              if (isOnline)
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppTheme.neonGreen,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.surfaceDark,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.neonGreen.withOpacity(0.6),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(width: 16),
          
          // Message Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: AppTheme.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      time,
                      style: AppTheme.bodySmall.copyWith(
                        color: hasUnread ? avatarColor : Colors.white54,
                        fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: AppTheme.bodyMedium.copyWith(
                          fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal,
                          color: hasUnread ? Colors.white : Colors.white60,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (unreadCount > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [avatarColor, avatarColor.withOpacity(0.7)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: avatarColor.withOpacity(0.4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Text(
                          unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
