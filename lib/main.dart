import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dlash_chat/screens/welcome_screen.dart';
import 'package:dlash_chat/screens/login_screen.dart';
import 'package:dlash_chat/screens/registration_screen.dart';
import 'package:dlash_chat/screens/chat_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures proper setup before Firebase initialization
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          textTheme: const TextTheme(
        bodySmall: TextStyle(color: Colors.black54),
      )),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen()
      },
    );
  }
}
