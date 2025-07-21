import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'as picker;
import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/customButton.dart';
import 'package:finance_tracker_frontend/widgets/customTextfield.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CreateBills extends StatefulWidget {
  const CreateBills({super.key});

  @override
  State<CreateBills> createState() => _CreateBillsState();
}

class _CreateBillsState extends State<CreateBills> {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String selectedDate = "DD/MM/YY";
  Map resData = {};

  Future<void> addBill()async{
    const uri = "http://192.168.1.8:4000/api/bills/add";
    final url = Uri.parse(uri);
    if (categoryController.text.isEmpty || amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      return;
    }
    final response = await http.post(url,
    headers: {
      "Authorization" : "Bearer $token",
      "Content-Type" : "application/json"
    },
    body: jsonEncode({
      "category" : categoryController.text.trim(),
      "amount" : amountController.text.trim(),
      "date" : selectedDate
    }));
       resData = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resData["message"] ?? 'Bill added successfully!'),
        ),
      );
      Navigator.pop(context); 
     
    } else {
      final resData = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resData["message"] ?? 'Failed to add bill'),
        ),
      );
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Create Bills',
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
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  const CustomText(
                    text: "CATEGORY NAME (Ex. Netflix)",
                    fontWeight: FontWeight.w500,
                    size: 17,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: categoryController,
                    hintText: "Category",
                    showSymbol: false,
                    numberType: false,
                  ),
                  const SizedBox(height: 17),
                  const CustomText(
                    text: "AMOUNT",
                    fontWeight: FontWeight.w500,
                    size: 17,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: amountController,
                    hintText: "Amount",
                    showSymbol: true,
                    numberType: true,
                  ),
                  const SizedBox(height: 17),
                  const CustomText(
                    text: "Date of Payment",
                    fontWeight: FontWeight.w500,
                    size: 17,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      picker.DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime: DateTime(2100, 12, 31),
                        currentTime: DateTime.now(),
                        onConfirm: (date) {
                          setState(() {
                            selectedDate =
                                "${date.day}/${date.month}/${date.year}";
                          });
                        },
                        locale: picker.LocaleType.en,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: selectedDate,
                            fontWeight: FontWeight.w400,
                            size: 18,
                            color: Colors.grey[600],
                          ),
                          const Icon(Icons.calendar_month, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Positioned(
            top: 520,
            left: 40,
            right: 40,
            child: CustomButton(
              buttonName: "Save",
              color: Colors.blue,
              width: 80,
              height: 55,
              onTap: () async{
                    await Future.delayed(const Duration(seconds: 1));
                    await addBill();
                  },
            ),
          ),
        ],
      ),
    );
  }
}
