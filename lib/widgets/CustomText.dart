import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color? color;

  const CustomText(
      {super.key,
      required this.text,
      required this.fontWeight,
      required this.size,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text,
      style: TextStyle(fontSize: size, fontWeight: fontWeight, color: color??Colors.black),
    );
  }
}
