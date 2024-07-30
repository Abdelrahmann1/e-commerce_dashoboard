import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'model.dart';
import 'new_controller.dart';

class AdminsChatScreensss extends StatelessWidget {
  final AdminsChatControllersss controller = Get.put(AdminsChatControllersss());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Chat'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.error.value.isNotEmpty) {
          return Center(child: Text('Error: ${controller.error.value}'));
        }

        return Row(
          children: [
            Expanded(
              flex: 2,
              child: UsersList(controller: controller),
            ),
            Expanded(
              flex: 3,
              child: ChatWindow(controller: controller),
            ),
          ],
        );
      }),
    );
  }
}

class UsersList extends StatelessWidget {
  final AdminsChatControllersss controller;

  UsersList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: controller.getUsersWithChats(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final usersWithChats = snapshot.data ?? [];
        print('UsersList: ${usersWithChats.length} users found'); // Debugging line
        if (usersWithChats.isEmpty) {
          return Center(child: Text('No users found with chats.'));
        }

        return ListView.builder(
          itemCount: usersWithChats.length,
          itemBuilder: (context, index) {
            final userId = usersWithChats[index];
            return ListTile(
              title: Text('User $userId'),
              onTap: () {
                controller.selectedUserId.value = userId;
                controller.getChatsForUser(userId).listen((chats) {
                  controller.chats.value = chats;
                });
              },
            );
          },
        );
      },
    );
  }
}

class ChatWindow extends StatelessWidget {
  final AdminsChatControllersss controller;

  ChatWindow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.selectedUserId.value.isEmpty) {
        return Center(child: Text('Select a user to start chatting.'));
      }

      return StreamBuilder<List<ChatModel>>(
        stream: controller.getChatsForUser(controller.selectedUserId.value),
        builder: (context, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (chatSnapshot.hasError) {
            return Center(child: Text('Error: ${chatSnapshot.error}'));
          }

          final chats = chatSnapshot.data ?? [];
          if (chats.isEmpty) {
            return Center(child: Text('No chats available for this user.'));
          }

          final chatId = chats.first.chatId;

          return Column(
            children: [
              Expanded(
                child: StreamBuilder<List<MessageModel>>(
                  stream: controller.getMessagesForChat(chatId),
                  builder: (context, messageSnapshot) {
                    if (messageSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (messageSnapshot.hasError) {
                      return Center(child: Text('Error: ${messageSnapshot.error}'));
                    }

                    final messages = messageSnapshot.data ?? [];
                    if (messages.isEmpty) {
                      return Center(child: Text('No messages yet.'));
                    }

                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return ListTile(
                          title: Text(message.messageText),
                          subtitle: Text('${message.senderId} - ${message.timestamp}'),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        final messageText = controller.messageController.text.trim();
                        if (messageText.isNotEmpty) {
                          controller.sendMessage(messageText);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
