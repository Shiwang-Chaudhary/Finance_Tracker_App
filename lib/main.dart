import 'package:finance_tracker_frontend/screens/addBudgets.dart';
import 'package:finance_tracker_frontend/screens/addTransaction.dart';
import 'package:finance_tracker_frontend/screens/budgetDetails.dart';
import 'package:finance_tracker_frontend/screens/bottombar.dart';
import 'package:finance_tracker_frontend/screens/loginScreen.dart';
import 'package:finance_tracker_frontend/screens/signUpScreen.dart';
import 'package:finance_tracker_frontend/screens/transExpenseDetail.dart';
import 'package:finance_tracker_frontend/screens/transaction.dart';
import 'package:finance_tracker_frontend/screens/wallet.dart';
import 'package:finance_tracker_frontend/widgets/customWalletButton.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return const MaterialApp(
     
      home: LoginScreen(),
    );
  }
}

// Test1234
