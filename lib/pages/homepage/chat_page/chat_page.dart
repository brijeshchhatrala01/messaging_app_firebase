import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/pages/components/custom_textformfield.dart';
import 'package:messaging_app/pages/homepage/bottom_navigation_pages/theme_page.dart';
import 'package:messaging_app/service/firebase_chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String reciverUserEmail;
  final String reciverUserId;
  const ChatPage(
      {super.key, required this.reciverUserEmail, required this.reciverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //chat service instance
  final _chatService = FirebaseChatService();

  //firebase auth instance
  final _firebaseAuth = FirebaseAuth.instance;

  //controller
  final _messageController = TextEditingController();

  //send message method
  void sendMessage() {
    _chatService.sendMessage(widget.reciverUserId, _messageController.text);

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: screenPickerColor,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              child: const Icon(Icons.person),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.reciverUserEmail,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessageFromDatabase(
          widget.reciverUserId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(QueryDocumentSnapshot<Object?> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: screenPickerColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Text(data['message']),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
              child: CustomTextFormField(
            controller: _messageController,
            keyboardType: TextInputType.text,
            isHideText: false,
            hintText: "Enter Message",
            prefixIcon: Icons.message_outlined,
            suffixIcon: Icons.send,
            onIconPressed: () {
              if (_messageController.text.isNotEmpty) {
                sendMessage();
              }
            },
          ))
        ],
      ),
    );
  }
}
