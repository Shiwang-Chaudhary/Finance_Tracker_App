import 'dart:convert';
import 'dart:developer';
import 'package:finance_tracker_frontend/screens/budgetDetails.dart';
import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/budgetTile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllBudget extends StatefulWidget {
  const AllBudget({super.key});

  @override
  State<AllBudget> createState() => _AllBudgetState();
}

class _AllBudgetState extends State<AllBudget> {
  bool isloading = true;
  List budgetList = [];
  Map resData = {};

  Future<void> getAllBudgets() async {
    final uri = "http://192.168.1.4:4000/api/budgets/getall";
    final url = Uri.parse(uri);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      return;
    }

    try {
      final response = await http.post(url, headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      });

      resData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        budgetList = resData["budget"];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(resData["message"] ?? 'Budgets retrieved successfully!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resData["message"] ?? 'Failed to retrieve budgets',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching budgets: $e')),
      );
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllBudgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false, // hides the back arrow
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'All Budgets',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 26),
        ),
        centerTitle: true,
      ),
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

          // Foreground
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: isloading
                      ? const Center(child: CircularProgressIndicator())
                      : budgetList.isEmpty
                          ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.hourglass_empty,
                                      size: 60, color: Colors.grey),
                                  SizedBox(height: 16),
                                  CustomText(
                                    text: "No Budgets Found 😢",
                                    fontWeight: FontWeight.w500,
                                    size: 22,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: budgetList.length,
                              itemBuilder: (context, index) {
                                final budget = budgetList[index];
                                final String budgetName = budget["budgetName"];
                                final String amount =
                                    (budget["amount"]).toString();
                                final String month = budget["month"];
                                return GestureDetector(
                                  onTap: () async {
                                    log("Amount : ${amount}");
                                    log("Note : ${budget["note"]}");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                 BudgetDetails(
                                                  //amount: amount, note: budget["note"] != "" ?  budget["note"] : "No note provided...",month: month,
                                                  )));
                                  },
                                  child: BudgetTile(
                                    title: budgetName,
                                    subtitle: amount,
                                    month: month,
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
