import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final Color color;
  final double width;
  final double height;
  final VoidCallback onTap;
  final double? fontsize;

  const CustomButton({
    Key? key,
    required this.buttonName,
    required this.color,
    required this.width,
    required this.height,
    required this.onTap,
    this.fontsize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12, // ⬆️ Increased elevation for a floating feel
      shadowColor: Colors.black.withOpacity(0.3), // Soft dark shadow
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            buttonName,
            style:  TextStyle(
              color: Colors.white,
              fontSize: fontsize ?? 19,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
