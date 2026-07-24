import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/realtime_chat_service.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_background.dart';

class ChatDetailScreen extends StatefulWidget {
  final String threadId;

  const ChatDetailScreen({
    super.key,
    required this.threadId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late RealtimeChatService _chatService;

  @override
  void initState() {
    super.initState();
    _chatService = RealtimeChatService();
    _chatService.addListener(_onChatUpdated);

    // Mark messages as read when entering
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatService.markThreadAsRead(widget.threadId);
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _chatService.removeListener(_onChatUpdated);
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onChatUpdated() {
    if (mounted) {
      setState(() {});
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleSendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      _chatService.sendMessage(widget.threadId, text);
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _sendQuickReply(String text) {
    _chatService.sendMessage(widget.threadId, text);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final thread = _chatService.getThread(widget.threadId);

    if (thread == null) {
      return Scaffold(
        backgroundColor: AppTheme.backgroundDark,
        appBar: AppBar(
          backgroundColor: AppTheme.surfaceDark,
          title: const Text('Chat Not Found'),
        ),
        body: const Center(
          child: Text(
            'Conversation thread does not exist.',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: PremiumBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(thread),

              // Chat Messages Stream
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  itemCount: thread.messages.length + (thread.isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == thread.messages.length && thread.isTyping) {
                      return _buildTypingIndicator(thread);
                    }
                    final msg = thread.messages[index];
                    return _buildMessageBubble(msg, thread.avatarColor);
                  },
                ),
              ),

              // Quick Reply Suggestions Chips
              _buildQuickReplies(),

              // Message Input Controller
              _buildInputArea(thread),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ChatThread thread) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 14),

          // Provider Avatar with status
          Stack(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: thread.avatarColor.withOpacity(0.2),
                child: Text(
                  thread.participantName[0],
                  style: TextStyle(
                    color: thread.avatarColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              if (thread.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppTheme.neonGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.surfaceDark, width: 2),
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
          const SizedBox(width: 14),

          // Provider info & role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  thread.participantName,
                  style: AppTheme.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  thread.isTyping ? 'typing...' : (thread.isOnline ? 'Active Now • ${thread.participantRole}' : thread.participantRole),
                  style: TextStyle(
                    color: thread.isTyping ? AppTheme.neonGreen : Colors.white54,
                    fontSize: 12,
                    fontWeight: thread.isTyping ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          // Action buttons (Call / More)
          IconButton(
            icon: const Icon(Icons.phone_in_talk_outlined, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppTheme.surfaceDark,
                  content: Text('Calling ${thread.participantName}...', style: const TextStyle(color: Colors.white)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, Color threadColor) {
    final isUser = message.isFromUser;
    final timeStr = "${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}";

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: threadColor.withOpacity(0.2),
              child: Text(
                message.senderName[0],
                style: TextStyle(color: threadColor, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: isUser
                    ? AppTheme.neonGradient
                    : LinearGradient(
                        colors: [AppTheme.surfaceDark, AppTheme.surfaceDark.withOpacity(0.9)],
                      ),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 20),
                ),
                border: Border.all(
                  color: isUser ? AppTheme.neonPurple.withOpacity(0.3) : Colors.white.withOpacity(0.08),
                ),
                boxShadow: [
                  BoxShadow(
                    color: isUser ? AppTheme.neonPurple.withOpacity(0.25) : Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.5,
                      height: 1.3,
                      fontWeight: isUser ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        timeStr,
                        style: TextStyle(
                          color: isUser ? Colors.white.withOpacity(0.7) : Colors.white38,
                          fontSize: 10,
                        ),
                      ),
                      if (isUser) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.done_all,
                          size: 14,
                          color: message.status == MessageStatus.read ? Colors.white : Colors.white60,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 200.ms).slideY(begin: 0.1);
  }

  Widget _buildTypingIndicator(ChatThread thread) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: thread.avatarColor.withOpacity(0.2),
            child: Text(
              thread.participantName[0],
              style: TextStyle(color: thread.avatarColor, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${thread.participantName.split(' ')[0]} is typing',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppTheme.neonGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildQuickReplies() {
    final replies = ['Are you on your way?', 'When can we start?', 'Please call me', 'Thank you!'];
    return Container(
      height: 38,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: replies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final reply = replies[index];
          return ActionChip(
            backgroundColor: AppTheme.surfaceDark,
            side: BorderSide(color: AppTheme.neonPurple.withOpacity(0.3)),
            label: Text(
              reply,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            onPressed: () => _sendQuickReply(reply),
          );
        },
      ),
    );
  }

  Widget _buildInputArea(ChatThread thread) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.add_photo_alternate_outlined, color: Colors.white70, size: 22),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Photo attachment added')),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: TextField(
                controller: _messageController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: Colors.white38),
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _handleSendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _handleSendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: AppTheme.neonGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.neonPurple.withOpacity(0.4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
