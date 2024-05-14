import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/model/message.dart';

class FirebaseChatService extends ChangeNotifier {
  //get instance of firebase auth and firebase firestore

  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFireStore = FirebaseFirestore.instance;

  //send message method
  Future<void> sendMessage(String reciverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email!;
    final timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      reciverId: reciverId,
      message: message,
      timestamp: timestamp,
    );

    //make new chatroom id for current user and reciver id
    List<String> ids = [currentUserId, reciverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _firebaseFireStore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
    notifyListeners();
  }

  //get message from database
  Stream<QuerySnapshot> getMessageFromDatabase(
      String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];

    ids.sort();

    String chatRoomId = ids.join('_');

    return _firebaseFireStore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
