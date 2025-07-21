import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final String button1;
  final String button2;
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final String title;
  final String message;

  const DialogBox({
    super.key,
    required this.button1,
    required this.button2,
    required this.title,
    required this.message,
    required this.onTap1,
    required this.onTap2,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: onTap1,
                child: Text(button1),
              ),
              TextButton(
                onPressed: onTap2,
                child: Text(button2),
              ),
            ],
          );
  }
}
