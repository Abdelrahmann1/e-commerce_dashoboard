import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;
  final String? lastMessage;
  final DateTime lastMessageTimestamp;

  ChatModel({
    required this.chatId,
    this.lastMessage,
    required this.lastMessageTimestamp,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['chatId'] as String,
      // userId: json['userId'] as String,
      lastMessage: json['lastMessage'] as String,
      lastMessageTimestamp: (json['lastMessageTimestamp'] as Timestamp).toDate(),
    );
  }
}

class MessageModel {
  final String messageId;
  final String senderId;
  final String messageText;
  final DateTime timestamp;
  final bool isRead;

  MessageModel({
    required this.messageId,
    required this.senderId,
    required this.messageText,
    required this.timestamp,
    required this.isRead,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json['messageId'] as String,
      senderId: json['senderId'] as String,
      messageText: json['messageText'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      isRead: json['isRead'] as bool,
    );
  }
}
