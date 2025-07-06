import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/customButton.dart';
import 'package:finance_tracker_frontend/widgets/customListTile.dart';
import 'package:finance_tracker_frontend/widgets/customTextfield.dart';
import 'package:finance_tracker_frontend/widgets/typeDropDown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
   TextEditingController categoryController = TextEditingController();
   TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 🔹 Allows body to go behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 🔹 Makes AppBar see-through
        elevation: 0, // 🔹 Removes shadow
        title: const Text(
          'Add transaction',
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
                  const CustomText(
                    text: "CATEGORY NAME (Ex. Netflix)",
                    fontWeight: FontWeight.w500,
                    size: 17,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  const SizedBox(height: 5),
                 CustomTextField(controller: categoryController, hintText: "Category",showSymbol: false,numberType: false,),
                  const SizedBox(height: 17),
                  const CustomText(
                    text: "AMOUNT",
                    fontWeight: FontWeight.w500,
                    size: 17,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  const SizedBox(height: 5),
                 CustomTextField(controller: amountController, hintText: "Amount",showSymbol: true,numberType: true,),
                  const SizedBox(height: 17),
                    const CustomText(
                    text: "TYPE",
                    fontWeight: FontWeight.w500,
                    size: 17,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  const SizedBox(height: 10),
                  TypeDropDown(),
                  SizedBox(height: 20,),
                
// Test Commit
                ],
              ),
            ),
          ),
            Positioned(
               top: 540, // 🔹 Control how far from top it should float
            left: 40,
            right: 40,
              child: CustomButton(buttonName: "Submit", color: Colors.blue, width: 80, height: 55, onTap: (){}))

          // Foreground Content
        ],
      ),
    );
  }
}
