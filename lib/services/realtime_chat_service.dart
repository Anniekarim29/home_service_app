import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum MessageStatus { sending, sent, delivered, read }

class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime timestamp;
  final bool isFromUser;
  final MessageStatus status;
  final String? attachmentUrl;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.timestamp,
    required this.isFromUser,
    this.status = MessageStatus.read,
    this.attachmentUrl,
  });

  ChatMessage copyWith({
    String? id,
    String? senderId,
    String? senderName,
    String? content,
    DateTime? timestamp,
    bool? isFromUser,
    MessageStatus? status,
    String? attachmentUrl,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isFromUser: isFromUser ?? this.isFromUser,
      status: status ?? this.status,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
    );
  }
}

class ChatThread {
  final String id;
  final String participantName;
  final String participantRole;
  final Color avatarColor;
  final bool isOnline;
  final List<ChatMessage> messages;
  final int unreadCount;
  final bool isTyping;

  ChatThread({
    required this.id,
    required this.participantName,
    required this.participantRole,
    required this.avatarColor,
    required this.isOnline,
    required this.messages,
    this.unreadCount = 0,
    this.isTyping = false,
  });

  ChatMessage? get lastMessage => messages.isNotEmpty ? messages.last : null;

  ChatThread copyWith({
    String? id,
    String? participantName,
    String? participantRole,
    Color? avatarColor,
    bool? isOnline,
    List<ChatMessage>? messages,
    int? unreadCount,
    bool? isTyping,
  }) {
    return ChatThread(
      id: id ?? this.id,
      participantName: participantName ?? this.participantName,
      participantRole: participantRole ?? this.participantRole,
      avatarColor: avatarColor ?? this.avatarColor,
      isOnline: isOnline ?? this.isOnline,
      messages: messages ?? this.messages,
      unreadCount: unreadCount ?? this.unreadCount,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

class RealtimeChatService extends ChangeNotifier {
  static final RealtimeChatService _instance = RealtimeChatService._internal();
  factory RealtimeChatService() => _instance;

  RealtimeChatService._internal() {
    _initializeInitialThreads();
  }

  final Map<String, ChatThread> _threads = {};

  List<ChatThread> get threads => _threads.values.toList();

  ChatThread? getThread(String threadId) => _threads[threadId];

  void _initializeInitialThreads() {
    final now = DateTime.now();

    _threads['support'] = ChatThread(
      id: 'support',
      participantName: 'Support Team',
      participantRole: 'Customer Support',
      avatarColor: const Color(0xFF00E5FF),
      isOnline: true,
      unreadCount: 3,
      messages: [
        ChatMessage(
          id: 's1',
          senderId: 'support',
          senderName: 'Support Team',
          content: 'Hello! How can we help you with your booking today?',
          timestamp: now.subtract(const Duration(minutes: 15)),
          isFromUser: false,
        ),
        ChatMessage(
          id: 's2',
          senderId: 'user',
          senderName: 'You',
          content: 'I wanted to confirm my AC repair appointment time.',
          timestamp: now.subtract(const Duration(minutes: 10)),
          isFromUser: true,
        ),
        ChatMessage(
          id: 's3',
          senderId: 'support',
          senderName: 'Support Team',
          content: 'Your booking has been confirmed for 3:00 PM today! 🎉',
          timestamp: now.subtract(const Duration(minutes: 2)),
          isFromUser: false,
        ),
      ],
    );

    _threads['sara'] = ChatThread(
      id: 'sara',
      participantName: 'Sara Ahmed',
      participantRole: 'Home Cleaning Specialist',
      avatarColor: const Color(0xFF00FF87),
      isOnline: true,
      unreadCount: 1,
      messages: [
        ChatMessage(
          id: 'sa1',
          senderId: 'sara',
          senderName: 'Sara Ahmed',
          content: 'Hi! I am on my way to your location.',
          timestamp: now.subtract(const Duration(hours: 2)),
          isFromUser: false,
        ),
        ChatMessage(
          id: 'sa2',
          senderId: 'user',
          senderName: 'You',
          content: 'Great, please let me know when you arrive.',
          timestamp: now.subtract(const Duration(hours: 1, minutes: 40)),
          isFromUser: true,
        ),
        ChatMessage(
          id: 'sa3',
          senderId: 'sara',
          senderName: 'Sara Ahmed',
          content: 'I will be there in 10 minutes. See you soon!',
          timestamp: now.subtract(const Duration(hours: 1)),
          isFromUser: false,
        ),
      ],
    );

    _threads['ali'] = ChatThread(
      id: 'ali',
      participantName: 'Ali Hassan',
      participantRole: 'Senior Electrician',
      avatarColor: const Color(0xFFBF5AF2),
      isOnline: false,
      unreadCount: 0,
      messages: [
        ChatMessage(
          id: 'al1',
          senderId: 'ali',
          senderName: 'Ali Hassan',
          content: 'The electrical wiring inspection is all set.',
          timestamp: now.subtract(const Duration(hours: 5)),
          isFromUser: false,
        ),
        ChatMessage(
          id: 'al2',
          senderId: 'user',
          senderName: 'You',
          content: 'Thank you Ali for the fast work!',
          timestamp: now.subtract(const Duration(hours: 4)),
          isFromUser: true,
        ),
        ChatMessage(
          id: 'al3',
          senderId: 'ali',
          senderName: 'Ali Hassan',
          content: 'The plumbing & wiring work is completed. Thank you!',
          timestamp: now.subtract(const Duration(hours: 3)),
          isFromUser: false,
        ),
      ],
    );

    _threads['usman'] = ChatThread(
      id: 'usman',
      participantName: 'Usman Gondal',
      participantRole: 'Plumbing Expert',
      avatarColor: const Color(0xFFFFD700),
      isOnline: false,
      unreadCount: 0,
      messages: [
        ChatMessage(
          id: 'us1',
          senderId: 'usman',
          senderName: 'Usman Gondal',
          content: 'I\'ll bring all the necessary pipe fitting equipment.',
          timestamp: now.subtract(const Duration(days: 1)),
          isFromUser: false,
        ),
      ],
    );

    _threads['bilal'] = ChatThread(
      id: 'bilal',
      participantName: 'Bilal Khan',
      participantRole: 'Painter & Decorator',
      avatarColor: const Color(0xFF26A69A),
      isOnline: false,
      unreadCount: 0,
      messages: [
        ChatMessage(
          id: 'bi1',
          senderId: 'bilal',
          senderName: 'Bilal Khan',
          content: 'Thanks for the 5-star review! 😊',
          timestamp: now.subtract(const Duration(days: 2)),
          isFromUser: false,
        ),
      ],
    );
  }

  void markThreadAsRead(String threadId) {
    if (_threads.containsKey(threadId)) {
      _threads[threadId] = _threads[threadId]!.copyWith(unreadCount: 0);
      notifyListeners();
    }
  }

  void sendMessage(String threadId, String content) {
    if (!_threads.containsKey(threadId) || content.trim().isEmpty) return;

    final thread = _threads[threadId]!;
    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'user',
      senderName: 'You',
      content: content.trim(),
      timestamp: DateTime.now(),
      isFromUser: true,
      status: MessageStatus.sent,
    );

    final updatedMessages = List<ChatMessage>.from(thread.messages)..add(userMsg);
    _threads[threadId] = thread.copyWith(messages: updatedMessages);
    notifyListeners();

    // Trigger simulated real-time provider response
    _simulateProviderReply(threadId, content);
  }

  void _simulateProviderReply(String threadId, String userMessage) {
    // Show typing status after 1 second
    Timer(const Duration(milliseconds: 1000), () {
      if (_threads.containsKey(threadId)) {
        _threads[threadId] = _threads[threadId]!.copyWith(isTyping: true);
        notifyListeners();
      }
    });

    // Send reply after 3 seconds
    Timer(const Duration(milliseconds: 3200), () {
      if (!_threads.containsKey(threadId)) return;

      final thread = _threads[threadId]!;
      String responseText = "Got it! Thanks for letting me know. I'm on it.";
      
      final lower = userMessage.toLowerCase();
      if (lower.contains('hello') || lower.contains('hi') || lower.contains('hey')) {
        responseText = "Hello! Great to hear from you. How can I assist with your service booking?";
      } else if (lower.contains('time') || lower.contains('when') || lower.contains('arrive')) {
        responseText = "I am tracking on schedule and will be at your doorstep very shortly!";
      } else if (lower.contains('price') || lower.contains('cost') || lower.contains('discount')) {
        responseText = "All service details and transparent pricing are available in your booking receipt.";
      } else if (lower.contains('thank') || lower.contains('thanks')) {
        responseText = "You're very welcome! Always happy to help provide top-quality service. 😊";
      }

      final replyMsg = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: thread.id,
        senderName: thread.participantName,
        content: responseText,
        timestamp: DateTime.now(),
        isFromUser: false,
      );

      final updatedMessages = List<ChatMessage>.from(thread.messages)..add(replyMsg);
      _threads[threadId] = thread.copyWith(
        messages: updatedMessages,
        isTyping: false,
        unreadCount: thread.unreadCount + 1,
      );
      notifyListeners();
    });
  }
}
