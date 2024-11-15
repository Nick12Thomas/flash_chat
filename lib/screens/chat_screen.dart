import 'package:dlash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:dlash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  static String id = "1";

  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }
  }
  void getMessage() async {
    try {
      // Fetch the documents from the 'messages' collection
      final QuerySnapshot msg = await _firestore.collection('messages').get();

      // Loop through each document in the collection
      for (var message in msg.docs) {
        print(message.data()); // Prints each document's data as a map
      }
    } catch (e) {
      print(e); // Handle and print any errors that occur
    }
  }


  void sendMessage() async {
    try {
      await _firestore.collection('messages').add({
        'text': messageText,
        'sender': loggedInUser?.email,
        //'createdAt': Timestamp.now(),
      });
      print("Message sent successfully");
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  void messageStream() async{
    await for(var snapshot in _firestore.collection('messages').snapshots()){
      for(var msg in snapshot.docs){
        print(msg.data());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // _auth.signOut();
                // Navigator.pushNamed(context, LoginScreen.id);
                messageStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: sendMessage,
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
