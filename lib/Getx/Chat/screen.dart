import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'model.dart';

// class AdminChatScreen extends StatelessWidget {
//   final AdminChatController chatController = Get.put(AdminChatController());
//
//   AdminChatScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Obx(() => Text(chatController.currentChatId.value.isEmpty
//               ? 'New Chat'
//               : 'Chat ${chatController.currentChatId.value.substring(0, 8)}...')),
//         ),
//         body: Obx(() {
//       if (chatController.isLoading.value) {
//         return Center(child: CircularProgressIndicator());
//       }
//
//       if (chatController.error.value.isNotEmpty) {
//         return Center(child: Text(chatController.error.value));
//       }
//
//       return Column(
//           children: [
//       Expanded(
//       child: chatController.messages.isEmpty
//           ? Center(child: Text('Initializing chat...'))
//         : ListView.builder(
//     itemCount: chatController.messages.length,
//     itemBuilder: (context, index) {
//     var message = chatController.messages[index];
//     bool isSentByAdmin = message.senderId == chatController.currentAdminId.value;
//
//     return MessageBubble(
//     message: message,
//     isSentByAdmin: isSentByAdmin,
//     );
//     },
//       ),
//       ),
//             Obx(() {
//               return chatController.isTyping.value
//                   ? Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text('User is typing...'),
//               )
//                   : SizedBox.shrink();
//             }),
//             MessageInput(
//               controller: chatController.messageController,
//               onChanged: (text) {
//                 if (chatController.currentChatId.value.isNotEmpty &&
//                     chatController.currentAdminId.value.isNotEmpty) {
//                   chatController.updateTypingStatus(text.isNotEmpty);
//                 }
//               },
//               onSubmitted: (text) {
//                 if (chatController.currentChatId.value.isNotEmpty &&
//                     chatController.currentAdminId.value.isNotEmpty) {
//                   chatController.sendMessage(text);
//                 }
//               },
//             ),
//           ],
//       );
//         }),
//     );
//   }
// }

// class MessageBubble extends StatelessWidget {
//   final MessageModel message;
//   final bool isSentByAdmin; // Adjusted to reflect admin in this version
//
//   MessageBubble({required this.message, required this.isSentByAdmin});
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isSentByAdmin ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         padding: EdgeInsets.all(8.0),
//         margin: EdgeInsets.all(4.0),
//         decoration: BoxDecoration(
//           color: isSentByAdmin ? Colors.blue : Colors.grey,
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Text(
//           message.messageText,
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
//
// class MessageInput extends StatelessWidget {
//   final TextEditingController controller;
//   final Function(String) onChanged;
//   final Function(String) onSubmitted;
//
//   MessageInput({required this.controller, required this.onChanged, required this.onSubmitted});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: controller,
//               onChanged: onChanged,
//               onSubmitted: onSubmitted,
//               decoration: InputDecoration(
//                 hintText: 'Type a message',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: () => onSubmitted(controller.text),
//           ),
//         ],
//       ),
//     );
//   }
// }

//
// // Admin Chat Screen
// class AdminsChatScreen extends StatelessWidget {
//   final AdminsChatController controller = Get.put(AdminsChatController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Chat'),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.error.value.isNotEmpty) {
//           return Center(child: Text('Error: ${controller.error.value}'));
//         }
//
//         return Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: UsersList(controller: controller),
//             ),
//             Expanded(
//               flex: 3,
//               child: ChatWindow(controller: controller),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
//
// class UsersList extends StatelessWidget {
//   final AdminsChatController controller;
//
//   UsersList({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<String>>(
//       stream: controller.getUsersWithChats(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//
//         final usersWithChats = snapshot.data ?? [];
//         print('UsersList: ${usersWithChats.length} users found'); // Debugging line
//         if (usersWithChats.isEmpty) {
//           return Center(child: Text('No users found with chats.'));
//         }
//
//         return ListView.builder(
//           itemCount: usersWithChats.length,
//           itemBuilder: (context, index) {
//             final userId = usersWithChats[index];
//             return ListTile(
//               title: Text('User $userId'),
//               onTap: () {
//                 controller.selectedUserId.value = userId;
//                 controller.getChatsForUser(userId).listen((chats) {
//                   controller.chats.value = chats;
//                 });
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }
// class ChatWindow extends StatelessWidget {
//   final AdminsChatController controller;
//
//   ChatWindow({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.selectedUserId.value.isEmpty) {
//         return Center(child: Text('Select a user to start chatting.'));
//       }
//
//       return StreamBuilder<List<ChatModel>>(
//         stream: controller.getChatsForUser(controller.selectedUserId.value),
//         builder: (context, chatSnapshot) {
//           if (chatSnapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (chatSnapshot.hasError) {
//             return Center(child: Text('Error: ${chatSnapshot.error}'));
//           }
//
//           final chats = chatSnapshot.data ?? [];
//           if (chats.isEmpty) {
//             return Center(child: Text('No chats available for this user.'));
//           }
//
//           final chatId = chats.first.chatId;
//
//           return Column(
//             children: [
//               Expanded(
//                 child: StreamBuilder<List<MessageModel>>(
//                   stream: controller.getMessagesForChat(chatId, controller.selectedUserId.value),
//                   builder: (context, messageSnapshot) {
//                     if (messageSnapshot.connectionState == ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     }
//
//                     if (messageSnapshot.hasError) {
//                       return Center(child: Text('Error: ${messageSnapshot.error}'));
//                     }
//
//                     final messages = messageSnapshot.data ?? [];
//                     print('Messages fetched: ${messages.length}');
//                     if (messages.isEmpty) {
//                       return Center(child: Text('No messages in this chat.'));
//                     }
//
//                     return ListView.builder(
//                       reverse: true,
//                       itemCount: messages.length,
//                       itemBuilder: (context, index) {
//                         final message = messages[index];
//                         final isAdmin = message.senderId == controller.adminId.value;
//
//                         return MessageBubble(message: message, isAdmin: isAdmin);
//                       },
//                     );
//                   },
//                 ),
//               ),
//               MessageInput(controller: controller),
//             ],
//           );
//         },
//       );
//     });
//   }
// }
//
//
// class MessageBubble extends StatelessWidget {
//   final MessageModel message;
//   final bool isAdmin;
//
//   MessageBubble({required this.message, required this.isAdmin});
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isAdmin ? Colors.blue[100] : Colors.grey[300],
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               isAdmin ? 'Admin' : 'User',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 4),
//             Text(message.messageText),
//             SizedBox(height: 4),
//             Text(
//               message.timestamp.toString(),
//               style: TextStyle(fontSize: 10, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MessageInput extends StatelessWidget {
//   final AdminsChatController controller;
//
//   MessageInput({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: controller.messageController,
//               decoration: InputDecoration(
//                 hintText: 'Type a message',
//                 border: OutlineInputBorder(),
//               ),
//               onSubmitted: (text) {
//                 if (text.isNotEmpty) {
//                   controller.sendMessage(text);
//                 }
//               },
//             ),
//           ),
//           SizedBox(width: 8),
//           ElevatedButton(
//             child: Text('Send'),
//             onPressed: () {
//               final text = controller.messageController.text;
//               if (text.isNotEmpty) {
//                 controller.sendMessage(text);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// Admin Chat Screen
class AdminsChatScreen extends StatelessWidget {
  final AdminsChatController controller = Get.put(AdminsChatController());

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
  final AdminsChatController controller;

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
  final AdminsChatController controller;

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
                    print('Messages fetched: ${messages.length}');
                    if (messages.isEmpty) {
                      return Center(child: Text('No messages in this chat.'));
                    }

                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isAdmin = message.senderId == controller.adminId.value;

                        return MessageBubble(message: message,isSentByUser: isAdmin,);
                      },
                    );
                  },
                ),
              ),
              MessageInput(controller: controller),
            ],
          );
        },
      );
    });
  }
}

// class MessageBubble extends StatelessWidget {
//   final MessageModel message;
//   final bool isAdmin;
//
//   MessageBubble({required this.message, required this.isAdmin});
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isAdmin ? Colors.blue[100] : Colors.grey[300],
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               isAdmin ? 'Admin' : 'User',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: isAdmin ? Colors.blue[700] : Colors.grey[700],
//               ),
//             ),
//             SizedBox(height: 4),
//             Text(message.messageText),
//             SizedBox(height: 4),
//             Text(
//               message.timestamp.toLocal().toString(), // Localize timestamp
//               style: TextStyle(fontSize: 10, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isSentByUser; // or isSentByAdmin for Admin version

  MessageBubble({required this.message, required this.isSentByUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: isSentByUser ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          message.messageText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class MessageInput extends StatelessWidget {
  final AdminsChatController controller;

  MessageInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  controller.sendMessage(text);
                }
              },
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            child: Text('Send'),
            onPressed: () {
              final text = controller.messageController.text;
              if (text.isNotEmpty) {
                controller.sendMessage(text);
              }
            },
          ),
        ],
      ),
    );
  }
}


class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:FutureBuilder<User?>(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            // User is logged in
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('Users').doc(snapshot.data!.uid).get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (userSnapshot.hasError) {
                  print('Error fetching user data: ${userSnapshot.error}');
                  return Center(child: Text('Error: ${userSnapshot.error}'));
                }

                if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                  print('User document does not exist for UID: ${snapshot.data!.uid}');
                  // Create a new user document if it doesn't exist
                  return FutureBuilder(
                    future: FirebaseFirestore.instance.collection('Users').doc(snapshot.data!.uid).
                  get(),
                    builder: (context, _) {
                      return SizedBox(); // Assume new users are not admins
                    },
                  );
                }

                final userData = userSnapshot.data!.data() as Map<String, dynamic>;
                final isAdmin = userData['isAdmin'] ?? false;

                if (isAdmin) {
                  return AdminsChatScreen();
                } else {
                  return SizedBox();
                }
              },
            );
          }

          // User is not logged in
          return SizedBox();
        },
      ),
    );

  }
}
