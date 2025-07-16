import 'dart:convert';
import 'dart:developer';
import 'package:finance_tracker_frontend/screens/global.dart' as global;
import 'package:finance_tracker_frontend/screens/wallet.dart';
import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/customButton.dart';
import 'package:finance_tracker_frontend/widgets/typeDropDown.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BudgetDetails extends StatefulWidget {
  //  final double amount;
  //  final String note;

  const BudgetDetails({super.key});

  @override
  State<BudgetDetails> createState() => _BudgetDetailsState();
}

class _BudgetDetailsState extends State<BudgetDetails> {
  bool isloading = true;
  //Map resData = {};
  String selectedMonth = "";
  double percent = 0.0;
  double remainingMoney = 0.0;
  Map budget = {};
  Future<void> getBudget() async {
    final uri = "http://192.168.1.4:4000/api/budgets/get";
    final url = Uri.parse(uri);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      return;
    }
    final response = await http.post(url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode({"month": selectedMonth}));
    final resData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final budgetList = resData["budget"];
      log("resData : $resData");
      log("budgetList : $budgetList");
      budget = budgetList[0];
      log("budget : $budget");
      budgetPercentUsed();
      isloading = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Budget for ${budget["month"]}" ??
              "Bugdet retrived successfully")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(resData["message"] ??
              "Can't get budget for ${budget["month"]}")));
    }
  }
  
  void budgetPercentUsed() {
    double a = (global.spent / budget["amount"]) * 100;
    print("spent : ${global.spent}");
    print("budgetAmount : ${budget["amount"]}");
    log(a.toString());
    if (a > 100) {
      a = 100;
      a.toStringAsFixed(1);
    }
    percent = double.parse(a.toStringAsFixed(1));
    double b = budget["amount"] - global.spent;
    if (b < 0) {
      b = 100;
    }
    remainingMoney = b;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getBudget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Budget',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 🔹 Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://imgs.search.brave.com/zBpotWQLBykUvnp_zyXFgHAXCW0UVDB-7a4_AK8maMI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2NmLzQy/LzJiL2NmNDIyYjI4/ZmNkN2VmNzdlYTc5/NWEzZGY2ZTkzZGI3/LmpwZw"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 Scrollable Content
          Positioned.fill(
            top: 80,
            child: SingleChildScrollView(
              // padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.75),
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
                  children: [
                    // 🔸 Circular Budget Stack
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 250,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: 0.0,
                              strokeWidth: 15,
                              backgroundColor:
                                  Color.fromARGB(255, 143, 204, 254),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: percent / 100,
                              strokeWidth: 15,
                              color: Colors.blue,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                text: "$percent%",
                                fontWeight: FontWeight.bold,
                                size: 40,
                                color: percent > 50
                                    ? Color.fromARGB(255, 255, 106, 95)
                                    : Colors.green,
                              ),
                              const SizedBox(height: 8),
                              CustomText(
                                text: "Budget used",
                                fontWeight: FontWeight.bold,
                                size: 22,
                                color: percent > 50
                                    ? Color.fromARGB(255, 255, 106, 95)
                                    : Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // const SizedBox(height: 30),

                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 143, 204, 254),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const CustomText(
                          text: "Remaining Budget",
                          fontWeight: FontWeight.w400,
                          size: 20,
                        ),
                        SizedBox(width: 110),
                        // CustomButton(
                        //   fontsize: 14,
                        //   buttonName: "ALL Budgets",
                        //   color: Colors.blue,
                        //   width: 70,
                        //   height: 30,
                        //   onTap: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (_) => Wallet()));
                        //   },
                        // ),
                      ],
                    ),

                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const CustomText(
                          text: "Spent Budget",
                          fontWeight: FontWeight.w400,
                          size: 20,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    TypeDropDown(
                      monthEnable: true,
                      text: "Please select a month for budget details",
                      onChanged: (value) async {
                        selectedMonth = value;
                        setState(() {});
                        await getBudget();
                      },
                    ),
                    const SizedBox(height: 20),
                    // 🔸 Budget + Edit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text:
                              "Total Budget (${isloading ? "None" : (budget["month"])})",
                          fontWeight: FontWeight.w500,
                          size: 19,
                          color: Colors.blue,
                        ),
                        // CustomButton(
                        //   buttonName: "Edit your Budget",
                        //   fontsize: 17,
                        //   color: Colors.blue,
                        //   width: 100,
                        //   height: 30,
                        //   onTap: () {},
                        // ),
                        TextButton(
                            onPressed: () {},
                            child: CustomText(
                              text: "(Edit Budget)",
                              fontWeight: FontWeight.w800,
                              size: 21,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: "₹ ${isloading ? "None" : budget["amount"]}",
                      fontWeight: FontWeight.bold,
                      size: 30,
                      color: Colors.blue,
                    ),

                    const SizedBox(height: 30),

                    // 🔸 Spent & Remaining
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Spent 📉",
                          fontWeight: FontWeight.w500,
                          size: 25,
                          color: Colors.red,
                        ),
                        CustomText(
                          text: "💰Remaining",
                          fontWeight: FontWeight.w500,
                          size: 25,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text:
                              "₹ ${isloading ? "None" : global.spent}", //from global
                          fontWeight: FontWeight.w500,
                          size: 25,
                          color: Color.fromARGB(255, 250, 105, 105),
                        ),
                        CustomText(
                          text: "₹ ${isloading ? "None" : remainingMoney}",
                          fontWeight: FontWeight.w500,
                          size: 25,
                          color: Color.fromARGB(255, 100, 209, 104),
                        ),
                      ],
                    ),

                    //    const SizedBox(height: 100),

                    CustomText(
                        text: "Note:", fontWeight: FontWeight.w500, size: 20),
                    const SizedBox(height: 20),

                    ReadMoreText(
                      isloading ? "Please select the month" : budget["note"],
                      trimLines: 2,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Read More',
                      trimExpandedText: 'Read Less',
                      style: TextStyle(fontSize: 19),
                      moreStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                      lessStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
