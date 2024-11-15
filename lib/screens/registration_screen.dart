import 'package:dlash_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:dlash_chat/constants.dart';
import 'package:dlash_chat/components/padded_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {

  static String id="3";

  const RegistrationScreen({super.key});
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth=FirebaseAuth.instance;
  bool isTrue=false;
  String email='';
  String password='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isTrue,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  email=value;
                  
                },
                decoration: kInputDecoration.copyWith(hintText: 'Enter your email')
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                  style: TextStyle(color: Colors.black),
                onChanged: (value) {
                 password=value;
                },
                decoration: kInputDecoration
              ),
              const SizedBox(
                height: 24.0,
              ),
          PaddingButton(onPressed: ()async{
           setState(() {
             isTrue=true;
           });
            try{
            final newUser=await _auth.createUserWithEmailAndPassword(email: email, password: password);
              Navigator.pushNamed(context, ChatScreen.id);
                          setState(() {
                isTrue=false;
              });
            }catch(e){
              print(e);
            }
          },colour: Colors.blueAccent,title: 'REGISTER',)
            ],
          ),
        ),
      ),
    );
  }
}
