import 'dart:convert';
import 'dart:developer';
import 'package:finance_tracker_frontend/screens/addBudgets.dart';
import 'package:finance_tracker_frontend/screens/addTransaction.dart';
import 'package:finance_tracker_frontend/screens/transIncomeDetail.dart';
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
  Future<void> getTransaction() async {
    try {
      const String uri = "http://192.168.1.4:4000/api/transactions/get";
      final url = Uri.parse(uri);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
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
      log(resData.toString());
      transList = resData["transaction"];
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                resData["message"] ?? 'Transaction retrived successfully!'),
          ),
        );

        isloading = false;
        setState(() {});
      } else {
        final resData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(resData["message"] ?? 'Failed to retrieve transactions'),
          ),
        );
        isloading = false;
        setState(() {});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching transactions: $e')),
      );
      isloading = false;
      setState(() {});
      return;
    }
  }
  Future <void> addWallet()async{
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTransaction();
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
                    "https://imgs.search.brave.com/zBpotWQLBykUvnp_zyXFgHAXCW0UVDB-7a4_AK8maMI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2NmLzQy/LzJiL2NmNDIyYjI4/ZmNkN2VmNzdlYTc5/NWEzZGY2ZTkzZGI3/LmpwZw"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground Content
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: "Good morning 👋",
                        fontWeight: FontWeight.w400,
                        size: 20),
                    CustomText(
                        text: "Shiwang Chaudhary",
                        fontWeight: FontWeight.w500,
                        size: 25)
                  ],
                ),
                const SizedBox(height: 220),
                const CustomText(
                    text: "Transaction history :",
                    fontWeight: FontWeight.w500,
                    size: 20),
                // ✅ Wrap ListView.builder in Expanded
               transList.isEmpty 
                    ? const Center(
                      child: Column(
                        children: [
                          SizedBox(height: 170,),
                          CustomText(
                                text: "No transactions found 😢",
                                fontWeight: FontWeight.w500,
                                size: 30,
                                color: Colors.grey,
                              ),
                          SizedBox(height: 90,),
                          CustomText(
                                text: "Create your first transaction",
                                fontWeight: FontWeight.w500,
                                size: 20,
                                color: Colors.black54,
                              ),

                        ],
                      ),
                    )
                    : isloading 
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                        child: ListView.builder(
                          itemCount: transList.length,
                          itemBuilder: (context, index) {
                            final transtile = transList[index];
                            final String date = transtile["date"];
                            if (transtile["type"] == "income") {
                              income = true;
                            } else {
                              income = false;
                            }
                            return TransactionTile(
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const TransIncomeDetail()));
                              },
                              icon: Icons.work,
                              title: transtile["category"] ?? "Category Name",
                              subtitle: date.split("T")[0],
                              amount: (transtile["amount"] as num).toDouble(),
                              amountColor: income ? Colors.green : Colors.red,
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
          Positioned(
            top: 120, // 🔹 Control how far from top it should float
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
                    offset: const Offset(0, 6), // shadow direction
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
                                  builder: (context) => const AddBudget()));
                        },
                      ),
                      CustomButton(
                        fontsize: 14,
                        buttonName: "+ Wallet",
                        color: Colors.blue,
                        width: 70,
                        height: 40,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Wallet()));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "₹ 12,500.00",
                        fontWeight: FontWeight.bold,
                        size: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Income",
                        fontWeight: FontWeight.w500,
                        size: 20,
                        color: Color.fromARGB(255, 216, 251, 255),
                      ),
                      CustomText(
                        text: "Expanses",
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
                        text: "₹ 9,500.00",
                        fontWeight: FontWeight.w500,
                        size: 20,
                        color: Color.fromARGB(255, 126, 255, 130),
                      ),
                      CustomText(
                        text: "₹ 5,500.00",
                        fontWeight: FontWeight.w500,
                        size: 20,
                        color: Color.fromARGB(255, 250, 105, 105),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: RawMaterialButton(
        onPressed: () async {
         await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTransaction()));
              
              await getTransaction();
                
             
        },
        fillColor: Color.fromRGBO(0, 191, 255, 1),
        shape: const CircleBorder(),
        constraints: const BoxConstraints.tightFor(
          width: 70.0,
          height: 70.0,
        ),
        elevation: 6.0,
        child: const Icon(Icons.add, size: 38, color: Colors.white),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // ✅ Center
    );
  }
}
