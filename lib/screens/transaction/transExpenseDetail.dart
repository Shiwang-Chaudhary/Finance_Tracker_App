import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/customButton.dart';
import 'package:flutter/material.dart';

class TransExpanseDetail extends StatefulWidget {
  const TransExpanseDetail({super.key});

  @override
  State<TransExpanseDetail> createState() => _TransExpanseDetailState();
}

class _TransExpanseDetailState extends State<TransExpanseDetail> {

  Future<void> getTransdetails()async{

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 🔹 Allows body to go behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 🔹 Makes AppBar see-through
        elevation: 0, // 🔹 Removes shadow
        title: const Text(
          'Transaction details',
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
            top: 140, // 🔹 Control how far from top it should float
            left: -19,
            right: -19,
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
                    offset: const Offset(0, 6), // shadow direction
                  ),
                ],
              ),
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: CustomText(text: "Netflix", fontWeight: FontWeight.bold, size: 30)),
                    Center(child: CustomText(text: "(expanse)", fontWeight: FontWeight.w400, size: 22,color: Colors.red,)),
                    SizedBox(height: 20,),
                    CustomText(text: "Transaction Details :", fontWeight: FontWeight.w600, size: 20,color: Color.fromARGB(255, 108, 107, 107),),
                    SizedBox(height: 20,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      CustomText(text: "Status", fontWeight: FontWeight.w400, size: 20,color: Color.fromARGB(255, 108, 107, 107),),
                      CustomText(text: "Expanse", fontWeight: FontWeight.w500, size: 17,color: Colors.red,),

                    ],),
                    SizedBox(height: 20,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      CustomText(text: "From", fontWeight: FontWeight.w400, size: 20,color: Color.fromARGB(255, 108, 107, 107),),
                      CustomText(text: "Upwork", fontWeight: FontWeight.w500, size: 17,color: Colors.black,),

                    ],),
                    SizedBox(height: 20,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      CustomText(text: "Date", fontWeight: FontWeight.w400, size: 20,color: Color.fromARGB(255, 108, 107, 107),),
                      CustomText(text: "20th dec, 2025", fontWeight: FontWeight.w500, size: 17,color: Colors.black,),

                    ],),
                    SizedBox(height: 10,),
                    Divider(),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      CustomText(text: "Earning", fontWeight: FontWeight.w400, size: 20,color: Color.fromARGB(255, 108, 107, 107),),
                      CustomText(text: "Rs. 850", fontWeight: FontWeight.w500, size: 17,color: Colors.red,),

                    ],),
                    SizedBox(height: 20,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      CustomText(text: "Total", fontWeight: FontWeight.w400, size: 20,color: Color.fromARGB(255, 108, 107, 107),),
                      CustomText(text: "Rs. 850", fontWeight: FontWeight.w500, size: 17,color: Colors.black,),

                    ],),
                    // SizedBox(height: 40,),
                    // Center(child: CustomButton(buttonName: "Edit", color: Colors.blue, width: 80, height: 55, onTap: (){})),


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
