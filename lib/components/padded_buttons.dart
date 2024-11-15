import 'package:flutter/material.dart';
class PaddingButton extends StatelessWidget {
  final String? title;
  final Color? colour;
  final VoidCallback onPressed;

  const PaddingButton({super.key, this.title, required this.onPressed, this.colour});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title ?? 'No Title', // Display default value if title is null
          ),
        ),
      ),
    );
  }
}
