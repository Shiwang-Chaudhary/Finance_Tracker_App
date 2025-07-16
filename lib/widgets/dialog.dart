import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final String button1;
  final String button2;
  final VoidCallback onTap1;
  final VoidCallback? onTap2;
  final String title;
  final String message;

  const DialogBox({
    super.key,
    required this.button1,
    required this.button2,
    required this.title,
    required this.message,
    required this.onTap1,
    this.onTap2,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onTap1();
                },
                child: Text(button1),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (onTap2 != null) onTap2!();
                },
                child: Text(button2),
              ),
            ],
          ),
        );
      },
      child: Text(title), // You can change this or make it a parameter too
    );
  }
}
