import 'package:finance_tracker_frontend/screens/addTransaction.dart';
import 'package:finance_tracker_frontend/screens/bottombar.dart';
import 'package:finance_tracker_frontend/screens/transExpenseDetail.dart';
import 'package:finance_tracker_frontend/screens/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
     
      home: TransExpanseDetail(),
    );
  }
}

// Test1234
