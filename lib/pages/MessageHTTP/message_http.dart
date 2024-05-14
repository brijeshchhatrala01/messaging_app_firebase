import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/custom_textformfield.dart';
import '../homepage/bottom_navigation_pages/theme_page.dart';

class MessageHttp extends StatefulWidget {
  const MessageHttp({super.key});

  @override
  State<MessageHttp> createState() => _MessageHttpState();
}

class _MessageHttpState extends State<MessageHttp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M E S S A G I N G  A P P'),
      ),
      body: Column(
        children: [
          FutureBuilder<List<dynamic>>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (snapshot.hasData) {
                return ListMessage(
                  messages: snapshot.data!,
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          _buildMessageInput()
        ],
      ),
    );
  }

  Future<List<dynamic>> getData() async {
    var resp = await http.get(
      Uri.parse(
        'https://zoological-wafer.000webhostapp.com/message/show_message.php',
      ),
    );
    return jsonDecode(resp.body);
  }
}

Widget _buildMessageInput() {
  var _messageController = TextEditingController();
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
              //sendMessage();
            }
          },
        ))
      ],
    ),
  );
}

class ListMessage extends StatelessWidget {
  final List messages;
  const ListMessage({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            var alignment = (messages[index]['messanger'] == 'Brijesh')
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
                child: Column(
                  crossAxisAlignment: messages[index]['messanger'] == 'Brijesh'
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      messages[index]['messanger'],
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    Text(messages[index]['message']),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
