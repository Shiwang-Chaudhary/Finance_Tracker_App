import 'dart:convert';
import 'dart:developer';
import 'package:finance_tracker_frontend/screens/budget/addBudgets.dart';
import 'package:finance_tracker_frontend/screens/transaction/addTransaction.dart';
import 'package:finance_tracker_frontend/screens/global.dart' as global;
import 'package:finance_tracker_frontend/screens/transaction/transIncomeDetail.dart';
import 'package:finance_tracker_frontend/screens/wallet.dart';
import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/customButton.dart';
import 'package:finance_tracker_frontend/widgets/transactionTile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List transList = [];
  Map resData = {};
  bool isloading = true;
  bool income = false;
  double totalSum = 0.0;
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  String? username = "";
  String? useremail= "";
  String dayTime = "";
  Future<void> getTransaction() async {
    try {
      String uri = "http://192.168.1.8:4000/api/transactions/get";
      final url = Uri.parse(uri);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? name = prefs.getString('name');
      final String? email = prefs.getString('email');
      setState(() {
        username = name;
        useremail = email;
      });
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not authenticated')),
        );
        return;
      }

      log(token);
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      resData = jsonDecode(response.body);
      transList = resData["transaction"];
      totalBalance();

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resData["message"] ?? 'Transactions retrieved successfully!',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resData["message"] ?? 'Failed to retrieve transactions',
            ),
          ),
        );
      }

      setState(() {
        isloading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching transactions: $e')),
      );
      setState(() {
        isloading = false;
      });
    }
  }

  void totalBalance() {
    totalIncome = 0.0;
    totalExpense = 0.0;
    for (var transaction in transList) {
      if (transaction["type"] == "income") {
        totalIncome += transaction["amount"];
      } else if (transaction["type"] == "expense") {
        totalExpense += transaction["amount"];
      }
    }
    setState(() {
      global.spent = totalExpense;
    totalSum = totalIncome - totalExpense;
    });
  }
  void timeOfDay(){
    String a = "";
    final DateTime now = DateTime.now();
    final part = now.toString().split(" ");
    final time = part[1].split(":");
    final int hour  = int.parse(time[0]);
    // log(now.toString());
    // log(time.toString());
    // log(hour.toString());
    if (hour>=5 && hour<12) {
       a = "Good Morning";
    }else if(hour>=12 && hour<16){
       a = "Good Afternoon";
    }else if(hour>=16 && hour<21){
       a = "Good Evening";
    }else {
       a = "Good Night";
    }
    log(a);
    setState(() {
    dayTime = a;
    });

  }

  @override
  void initState() {
    super.initState();
    getTransaction();
    timeOfDay();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://imgs.search.brave.com/zBpotWQLBykUvnp_zyXFgHAXCW0UVDB-7a4_AK8maMI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2NmLzQy/LzJiL2NmNDIyYjI4/ZmNkN2VmNzdlYTc5/NWEzZGY2ZTkzZGI3/LmpwZw",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground Content
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                 Column(
                 // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "${dayTime} 👋",
                      fontWeight: FontWeight.w400,
                      size: 20,
                    ),
                    CustomText(
                      text: username ?? "Sir",
                      fontWeight: FontWeight.w500,
                      size: 25,
                    ),
                  ],
                ),
                const SizedBox(height: 220),
                const CustomText(
                  text: "Transaction history :",
                  fontWeight: FontWeight.w500,
                  size: 20,
                ),

                // ✅ Final Section: Loading or Empty or List
                Expanded(
                  child: isloading
                      ? const Center(child: CircularProgressIndicator())
                      : transList.isEmpty
                          ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.hourglass_empty,
                                      size: 60, color: Colors.grey),
                                  SizedBox(height: 16),
                                  CustomText(
                                    text: "No Transactions Found 😢",
                                    fontWeight: FontWeight.w500,
                                    size: 22,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  CustomText(
                                    text: "Create your first transaction",
                                    fontWeight: FontWeight.w400,
                                    size: 16,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: transList.length,
                              itemBuilder: (context, index) {
                                final transtile = transList[index];
                                final String date = transtile["date"];
                                income = transtile["type"] == "income";

                                return TransactionTile(
                                  ontap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => TransIncomeDetail(
                                          amount:
                                              (transtile["amount"] as num).toDouble(),
                                          category: transtile["category"] ??
                                              "Category Name",
                                          date: date.split("T")[0],
                                          transType: transtile["type"],
                                          amountColor: transtile["type"] ==
                                                  "income"
                                              ? Colors.green
                                              : Colors.red,
                                          note: transtile["note"] != ""
                                              ? transtile["note"]
                                              : "No note added...",
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icons.attach_money_outlined,
                                  title:
                                      transtile["category"] ?? "Category Name",
                                  subtitle: date.split("T")[0],
                                  amount:
                                      (transtile["amount"] as num).toDouble(),
                                  amountColor: transtile["type"] == "income"
                                      ? Colors.green
                                      : Colors.red,
                                );
                              },
                            ),
                ),
              ],
            ),
          ),

          // Floating Card with total balance
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(61, 179, 243, 1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                        text: "Total balance",
                        fontWeight: FontWeight.w500,
                        size: 20,
                        color: Colors.white,
                      ),
                      CustomButton(
                        fontsize: 14,
                        buttonName: "+ Budget",
                        color: Colors.blue,
                        width: 75,
                        height: 40,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AddBudget(),
                            ),
                          );
                        },
                      ),
                      CustomButton(
                        fontsize: 14,
                        buttonName: "+ Wallet",
                        color: Colors.blue,
                        width: 70,
                        height: 40,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Wallet(totalSum: totalSum),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "₹ $totalSum",
                        fontWeight: FontWeight.bold,
                        size: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Income",
                        fontWeight: FontWeight.w500,
                        size: 20,
                        color: Color.fromARGB(255, 216, 251, 255),
                      ),
                      const CustomText(
                        text: "Expenses",
                        fontWeight: FontWeight.w500,
                        size: 20,
                        color: Color.fromARGB(255, 216, 251, 255),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "₹ $totalIncome",
                        fontWeight: FontWeight.w500,
                        size: 20,
                        color: const Color.fromARGB(255, 126, 255, 130),
                      ),
                      CustomText(
                        text: "₹ $totalExpense",
                        fontWeight: FontWeight.w500,
                        size: 20,
                        color: const Color.fromARGB(255, 250, 105, 105),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: RawMaterialButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransaction(totalSum: totalSum),
            ),
          );
          await getTransaction(); // 🔁 Refresh after add
        },
        fillColor: const Color.fromRGBO(0, 191, 255, 1),
        shape: const CircleBorder(),
        constraints: const BoxConstraints.tightFor(
          width: 70.0,
          height: 70.0,
        ),
        elevation: 6.0,
        child: const Icon(Icons.add, size: 38, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
