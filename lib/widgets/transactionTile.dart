import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final double amount;
  final Color amountColor;
  final VoidCallback ontap;

  const TransactionTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.amountColor,
    required this.ontap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ontap,
      child: Card(
        color: Color.fromARGB(255, 255, 255, 255),
        elevation: 0.5, // controls how "raised" it looks
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child:ListTile(
        leading: Icon(icon,size: 30,color: Colors.blue,),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: Text(
          " ₹${amount.toString()}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: amountColor,
            fontSize: 16,
          ),
        ),
      )),
    );
  }
}
