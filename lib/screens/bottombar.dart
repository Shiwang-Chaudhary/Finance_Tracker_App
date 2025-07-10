import 'package:finance_tracker_frontend/screens/addBudgets.dart';
import 'package:finance_tracker_frontend/screens/budgetDetails.dart';
import 'package:finance_tracker_frontend/screens/transaction.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;
  List screens = [
    const Transactions(),
     const BudgetDetails(),
    // const ProfileScreen(),
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    print(index);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}