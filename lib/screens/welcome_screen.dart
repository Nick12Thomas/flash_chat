import 'package:dlash_chat/screens/login_screen.dart';
import 'package:dlash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dlash_chat/components/padded_buttons.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "0";

  const WelcomeScreen({super.key});
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController colorController;
  late Animation backgroundColorAnimation;

  @override
  void initState() {
    super.initState();

    // Controller for background color that runs only once
    colorController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    backgroundColorAnimation = ColorTween(begin: Colors.grey, end: Colors.white)
        .animate(colorController);
    colorController.forward(); // Run once and stop

    colorController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    colorController.dispose(); // Dispose color controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      backgroundColorAnimation.value, // Set animated background color
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(animatedTexts: [
                  TypewriterAnimatedText('Flash Chat',
                      textStyle: const TextStyle(
                          fontSize: 45,
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.w900))
                ])
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            PaddingButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              colour: Colors.lightBlueAccent,
              title: 'LOG IN',
            ),
            PaddingButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              colour: Colors.blue,
              title: 'REGISTER',
            )
          ],
        ),
      ),
    );
  }
}

