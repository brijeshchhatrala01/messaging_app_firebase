import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/pages/homepage/chat_page/chat_page.dart';
import 'package:messaging_app/pages/components/nav_drawer.dart';
import 'package:messaging_app/pages/homepage/bottom_navigation_pages/theme_page.dart';


//app's login user's list pages
class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  //instance of firebaseauth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserLIst(),
      drawer: const CustomNavigationDrawer(),
    );
  }

  Widget _buildUserLIst() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
          children: snapshot.data!.docs
              .map((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data();
    if (_firebaseAuth.currentUser!.email != data['email']) {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListTile(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  reciverUserEmail: data['email'],
                  reciverUserId: data['uid'],
                ),
              )),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tileColor: screenPickerColor,
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            child: const Icon(Icons.person),
          ),
          title: Text(
            data['email'],
            style: const TextStyle(fontSize: 14),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
