// 📁 lib/widgets/budgetTile.dart
import 'package:flutter/material.dart';
import 'CustomText.dart'; // or adjust path if needed

class BudgetTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String month;

  const BudgetTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      shadowColor: Colors.black26,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: CustomText(
          text: title,
          fontWeight: FontWeight.bold,
          size: 20,
          color: Colors.blue.shade900,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: CustomText(
            text: "₹ $subtitle",
            fontWeight: FontWeight.w400,
            size: 16,
            color: Colors.black87,
          ),
        ),
        trailing: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            month,
            style: TextStyle(
              color: Colors.blue.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
