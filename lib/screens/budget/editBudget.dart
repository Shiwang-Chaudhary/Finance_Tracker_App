import 'dart:convert';
import 'dart:developer';

import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/customButton.dart';
import 'package:finance_tracker_frontend/widgets/customTextfield.dart';
import 'package:finance_tracker_frontend/widgets/typeDropDown.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class EditBudget extends StatefulWidget {
  final String budgetID;
  const EditBudget({super.key,required this.budgetID});

  @override
  State<EditBudget> createState() => _EditBudgetState();
}

class _EditBudgetState extends State<EditBudget> {
  TextEditingController amountCont = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String selectedMonth = "";
  Future<void> editBudget()async{
    final uri = "http://192.168.1.8:4000/api/budgets/update/${widget.budgetID}";
    final url = Uri.parse(uri);
    if (amountCont.text.trim().isEmpty||nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all the arguments first'),duration: Duration(seconds: 1),),
        );
        return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
      "budgetName" : nameController.text.trim(),
      "amount" : amountCont.text.trim(),
      "month" : selectedMonth,
      "note" : noteController.text.trim()
    }));
    final resData = jsonDecode(response.body);
    print(response.statusCode);
    print("Response message : ${resData["message"]}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                resData["message"] ?? 'Budget updated successfully!'),
          ),
        );
        Navigator.pop(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resData["message"] ?? 'Failed to update Budget'),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 🔹 Allows body to go behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 🔹 Makes AppBar see-through
        elevation: 0, // 🔹 Removes shadow
        title: const Text(
          'Edit Budget',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 26),
        ),
        centerTitle: true,
      ),
      body:Stack(
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
            top: 130, // 🔹 Control how far from top it should float
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:  Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 6), // shadow direction
                  ),
                ],
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const SizedBox(height: 17),
                  const CustomText(
                    text: "NAME OF BUDGET (Ex. January's Budget)",
                    fontWeight: FontWeight.w500,
                    size: 17,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  const SizedBox(height: 5),
               CustomTextField(controller: nameController, hintText: "Budget's name",showSymbol: false,numberType: false,),
                         
                  const SizedBox(height: 17),
                  const CustomText(
                    text: "AMOUNT",
                    fontWeight: FontWeight.w500,
                    size: 17,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  const SizedBox(height: 5),
               CustomTextField(controller: amountCont, hintText: "Amount",showSymbol: true,numberType: true,),
                  const SizedBox(height: 17),
                    const CustomText(
                    text: "MONTH",
                    fontWeight: FontWeight.w500,
                    size: 17,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  const SizedBox(height: 10),
                  TypeDropDown(monthEnable: true, text: "Select Month",onChanged: (value){
                    selectedMonth = value;
                    setState(() {
                      
                    });
                  },),
                  SizedBox(height: 20,),
                    const CustomText(
                    text: "NOTE (optinal)",
                    fontWeight: FontWeight.w500,
                    size: 17,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  const SizedBox(height: 15),
               CustomTextField(maxlines: 5,controller: noteController, hintText: "Description",showSymbol: false,numberType: false,),
                  const SizedBox(height: 17),
                ],
              ),
            ),
          ),
            Positioned(
               top: 750, // 🔹 Control how far from top it should float
            left: 40,
            right: 40,
              child: CustomButton(buttonName: "Submit", color: Colors.blue, width: 80, height: 55, onTap: ()async{
                await editBudget();
                log("Edit budget hit");
                
              }))

          // Foreground Content
        ],
      ),
   
    );
  }
}