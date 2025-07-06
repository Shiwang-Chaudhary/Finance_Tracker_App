import 'package:finance_tracker_frontend/screens/addTransaction.dart';
import 'package:finance_tracker_frontend/screens/transIncomeDetail.dart';
import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/customListTile.dart';
import 'package:flutter/material.dart';


class Transactions extends StatelessWidget {
  const Transactions({super.key});

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
                SizedBox(height: 30,),
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "Good morning 👋", fontWeight: FontWeight.w400, size: 20),
                    CustomText(text: "Shiwang Chaudhary", fontWeight: FontWeight.w500, size: 25)
                  ],
                ),
                const SizedBox(height: 220),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: "Transaction history :",
                        fontWeight: FontWeight.w500,
                        size: 20),
                    CustomText(
                      text: "See all",
                      fontWeight: FontWeight.w400,
                      size: 17,
                      color: Colors.grey,
                    ),
                  ],
                ),
                // ✅ Wrap ListView.builder in Expanded
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return  TransactionTile(
                        ontap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>TransIncomeDetail()));
                        },
                        icon: Icons.work,
                        title: "Upwork",
                        subtitle: "Today",
                        amount: 850,
                        amountColor: Colors.green,
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
            child : Container(
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Total balance", fontWeight: FontWeight.w500, size: 20,color: Colors.white,),
                SizedBox(height: 5),
                CustomText(text: "₹ 12,500.00", fontWeight: FontWeight.bold, size: 30,color: Colors.white,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  CustomText(text: "Income", fontWeight: FontWeight.w500, size: 20,color: Color.fromARGB(255, 216, 251, 255),),
                  CustomText(text: "Expanses", fontWeight: FontWeight.w500, size: 20,color:Color.fromARGB(255, 216, 251, 255),),
                ],),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  CustomText(text: "₹ 9,500.00", fontWeight: FontWeight.w500, size: 20,color: Color.fromARGB(255, 126, 255, 130),),
                  CustomText(text: "₹ 5,500.00", fontWeight: FontWeight.w500, size: 20,color: Color.fromARGB(255, 250, 105, 105),),
                ],),
              ],
            ),
          ),)
        ],
      ),
      floatingActionButton: RawMaterialButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTransaction()));
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
