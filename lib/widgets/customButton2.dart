import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final double fontSize;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;

  const CustomButton2({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 200,
    this.height = 50,
    this.fontSize = 16,
    this.textColor = Colors.purple,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.purple,
    this.borderWidth = 2.0,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
  foregroundColor: MaterialStateProperty.all<Color>(textColor),
  elevation: MaterialStateProperty.all<double>(4.0),
  shadowColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.5)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      side: BorderSide(
        color: borderColor,
        width: borderWidth,
      ),
    ),
  ),
),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
