import 'package:finance_tracker_frontend/screens/budget/addBudgets.dart';
import 'package:finance_tracker_frontend/screens/transaction/addTransaction.dart';
import 'package:finance_tracker_frontend/screens/budget/budgetDetails.dart';
import 'package:finance_tracker_frontend/screens/bottombar.dart';
import 'package:finance_tracker_frontend/screens/auth/loginScreen.dart';
import 'package:finance_tracker_frontend/screens/auth/signUpScreen.dart';
import 'package:finance_tracker_frontend/screens/transaction/transExpenseDetail.dart';
import 'package:finance_tracker_frontend/screens/transaction/transaction.dart';
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
    return  MaterialApp(
      theme: ThemeData(
        useMaterial3: false, // This disables Material 3 globally
        // Your other theme properties...
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

// Test1234
