import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'model.dart';

class AdminsChatControllersss extends GetxController {
  var usersWithChats = <String>[].obs;
  var selectedUserId = ''.obs;
  var chats = <ChatModel>[].obs;
  var messages = <MessageModel>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;
  var adminId = ''.obs;

  final TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchAdminId().then((_) => getUsersWithChats().listen((users) {
      usersWithChats.value = users;
      isLoading.value = false;
    }));
  }

  Future<void> fetchAdminId() async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('No user is currently signed in');
      }

      if (currentUser.email != null) {
        final adminSnapshot = await FirebaseFirestore.instance
            .collection('Admins')
            .doc(currentUser.email)
            .get();

        if (adminSnapshot.exists) {
          adminId.value = adminSnapshot.id;
          return;
        }
      }

      final querySnapshot = await FirebaseFirestore.instance
          .collection('Admins')
          .where('id', isEqualTo: currentUser.uid)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        adminId.value = querySnapshot.docs.first.id;
      } else {
        throw Exception('Current user (${currentUser.uid}) is not found in Admins collection');
      }
    } catch (e) {
      error.value = 'Failed to fetch admin ID: $e';
      print('Error in fetchAdminId: ${error.value}');
    }
  }

  Future<void> sendMessage(String messageText) async {
    if (messageText.isEmpty || selectedUserId.value.isEmpty) {
      print('Validation failed: messageText or selectedUserId is empty.');
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      final adminChatsRef = FirebaseFirestore.instance
          .collection('Admins')
          .doc(adminId.value)
          .collection('Chats');

      final chatSnapshot = await adminChatsRef
          .where('userId', isEqualTo: selectedUserId.value)
          .limit(1)
          .get();

      DocumentReference chatRef;

      if (chatSnapshot.docs.isNotEmpty) {
        chatRef = chatSnapshot.docs.first.reference;
      } else {
        chatRef = adminChatsRef.doc();
        await chatRef.set({
          'userId': selectedUserId.value,
          'lastMessage': messageText,
          'lastMessageTimestamp': FieldValue.serverTimestamp(),
        });
        print('New chat document created in Admins -> Chats: ${chatRef.id}');
      }

      final messageRef = chatRef.collection('Messages').doc();

      await messageRef.set({
        'senderId': adminId.value,
        'messageText': messageText,
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false,
      });

      print('Message successfully set in Admins -> Chats -> Messages.');

      await chatRef.update({
        'lastMessage': messageText,
        'lastMessageTimestamp': FieldValue.serverTimestamp(),
      });

      print('Chat document updated in Admins -> Chats.');

      messageController.clear();
    } catch (e) {
      error.value = 'Failed to send message: $e';
      print('Error in sendMessage: ${error.value}');
    } finally {
      isLoading.value = false;
    }
  }

  Stream<List<String>> getUsersWithChats() {
    return FirebaseFirestore.instance.collection('Users').snapshots().asyncMap((usersSnapshot) async {
      List<String> usersWithChatsList = [];
      for (var userDoc in usersSnapshot.docs) {
        final chatSnapshot = await FirebaseFirestore.instance
            .collection('Admins')
            .doc(adminId.value)
            .collection('Chats')
            .where('userId', isEqualTo: userDoc.id)
            .limit(1)
            .get();
        if (chatSnapshot.docs.isNotEmpty) {
          usersWithChatsList.add(userDoc.id);
        }
      }
      print('Users with chats: $usersWithChatsList'); // Debugging line
      return usersWithChatsList;
    }).handleError((error) {
      print('Error fetching users with chats: $error');
      throw error;
    });
  }

  Stream<List<ChatModel>> getChatsForUser(String userId) {
    if (userId.isEmpty) return Stream.value([]);

    return FirebaseFirestore.instance
        .collection('Admins')
        .doc(adminId.value)
        .collection('Chats')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatModel(
          chatId: doc.id,
          lastMessage: doc['lastMessage'] ?? '',
          lastMessageTimestamp: doc['lastMessageTimestamp']?.toDate() ?? DateTime.now(),
        );
      }).toList();
    });
  }

  Stream<List<MessageModel>> getMessagesForChat(String chatId) {
    if (chatId.isEmpty) return Stream.value([]);

    return FirebaseFirestore.instance
        .collection('Admins')
        .doc(adminId.value)
        .collection('Chats')
        .doc(chatId)
        .collection('Messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      print('Fetched ${snapshot.docs.length} messages');
      return snapshot.docs.map((doc) {
        return MessageModel(
          messageId: doc.id,
          senderId: doc['senderId'],
          messageText: doc['messageText'],
          timestamp: doc['timestamp']?.toDate() ?? DateTime.now(),
          isRead: doc['isRead'] ?? false,
        );
      }).toList();
    }).handleError((error) {
      print('Error fetching messages: $error');
      throw error;
    });
  }
}
