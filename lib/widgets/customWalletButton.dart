import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:flutter/material.dart';

class CustomWalletButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final double? radius;
  final double? iconSize;
  final ontap;
  const CustomWalletButton({super.key,
    required this.text,
    required this.icon,
    required this.ontap,
    this.radius,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return 
       Column(mainAxisAlignment: MainAxisAlignment.center, children: [
         ElevatedButton(
           onPressed: ontap,
           style: ElevatedButton.styleFrom(
             shape: const CircleBorder(),
             backgroundColor: Color.fromARGB(255, 255, 255, 255), 
             elevation: 0,
             surfaceTintColor: Colors.transparent,
             padding:  EdgeInsets.all(radius ?? 20), 
             side: const BorderSide(
                 color: Colors.blue, width: 2),
           ),
           child: Icon(
             icon, 
             color: Colors.blue,
             size: iconSize ?? 30,
           ),
         ),
         CustomText(text: text, fontWeight: FontWeight.w400, size: 20)
       ]
    );
  }
}
