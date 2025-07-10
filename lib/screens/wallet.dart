import 'package:finance_tracker_frontend/screens/addTransaction.dart';
import 'package:finance_tracker_frontend/screens/createBills.dart';
import 'package:finance_tracker_frontend/screens/transIncomeDetail.dart';
import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/billTile.dart';
import 'package:finance_tracker_frontend/widgets/customWalletButton.dart';
import 'package:finance_tracker_frontend/widgets/transactionTile.dart';
import 'package:flutter/material.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

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
              child:   Column(
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
                SizedBox(width: 290,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomWalletButton(text: "Add Money", icon: Icons.add,radius: 15,iconSize: 30,ontap: (){},),
                      CustomWalletButton(text: "Create Bills", icon: Icons.receipt_long_rounded,radius: 15,ontap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>const CreateBills()));
                      },iconSize: 30,),
                    //  CustomWalletButton(text: "Send", icon: Icons.send,radius: 15,ontap: (){},iconSize: 30,),
                  
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
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
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return  BillTile(icon: Icons.login, iconColor: Colors.black, name: "Youtube", date: "8 July,2025", onPay: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>AddTransaction()));
                        },);
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