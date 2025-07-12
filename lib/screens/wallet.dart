import 'dart:convert';
import 'dart:developer';

import 'package:finance_tracker_frontend/screens/addTransaction.dart';
import 'package:finance_tracker_frontend/screens/addWalletMoney.dart';
import 'package:finance_tracker_frontend/screens/createBills.dart';
import 'package:finance_tracker_frontend/screens/transIncomeDetail.dart';
import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/billTile.dart';
import 'package:finance_tracker_frontend/widgets/customWalletButton.dart';
import 'package:finance_tracker_frontend/widgets/transactionTile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  Map resData = {};
  List billList = [];
  Future<void> getBills() async {
    final uri = "http://192.168.1.4:4000/api/bills/get";
    final url = Uri.parse(uri);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      return;
    }
    final response = await http.post(url, headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    });

    resData = jsonDecode(response.body);
    print(response.statusCode);
    billList = resData["bill"];
    log(resData.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(resData["message"] ?? 'All bills retrived successfully!'),
        ),
      );
    } else {
      resData = jsonDecode(response.body);
      log(resData.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resData["message"] ?? 'Failed to load bills'),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 🔹 Allows body to go behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 🔹 Makes AppBar see-through
        elevation: 0, // 🔹 Removes shadow
        title: const Text(
          'Wallet',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 26),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://imgs.search.brave.com/zBpotWQLBykUvnp_zyXFgHAXCW0UVDB-7a4_AK8maMI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2NmLzQy/LzJiL2NmNDIyYjI4/ZmNkN2VmNzdlYTc5/NWEzZGY2ZTkzZGI3/LmpwZw"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 80, // 🔹 Control how far from top it should float
            left: 0,
            right: 0,
            child: Container(
              //margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(
                    text: "Total balance",
                    fontWeight: FontWeight.w500,
                    size: 17,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  const SizedBox(height: 10),
                  const CustomText(
                    text: "Rs. 12500",
                    fontWeight: FontWeight.bold,
                    size: 30,
                    color: Colors.black,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 290,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomWalletButton(
                          text: "Add Money",
                          icon: Icons.add,
                          radius: 15,
                          iconSize: 30,
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AddTransaction()));
                          },
                        ),
                        CustomWalletButton(
                          text: "Create Bills",
                          icon: Icons.receipt_long_rounded,
                          radius: 15,
                          ontap: ()async {
                           await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CreateBills()));
                             getBills();
                          },
                          iconSize: 30,
                        ),
                        //  CustomWalletButton(text: "Send", icon: Icons.send,radius: 15,ontap: (){},iconSize: 30,),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomText(
                      text: " Upcoming Bills :",
                      fontWeight: FontWeight.w500,
                      size: 20),
                  SizedBox(
                    height: 10,
                  ),
                  // ✅ Wrap ListView.builder in Expanded
                  SizedBox(
                    height: 550, // Set a fixed height for the ListView
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: billList.length,
                        itemBuilder: (context, index) {
                          final Map bill = billList[index];
                          final String billName = bill["category"];
                          final String billDate = bill["date"];
                          // final double amount = bill["amount"];

                          return BillTile(
                            icon: Icons.receipt_long_outlined,
                            iconColor: Colors.blue,
                            name: billName,
                            date: billDate,
                            amount: (bill["amount"] as num).toDouble(),
                            onPay: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AddTransaction()));
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
