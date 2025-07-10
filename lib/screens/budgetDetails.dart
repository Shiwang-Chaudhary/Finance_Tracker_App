import 'package:finance_tracker_frontend/screens/wallet.dart';
import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/customButton.dart';
import 'package:finance_tracker_frontend/widgets/typeDropDown.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class BudgetDetails extends StatelessWidget {
  const BudgetDetails({super.key});

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
                    const SizedBox(
                      height: 250,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: 0.25,
                              strokeWidth: 15,
                              backgroundColor:
                                  Color.fromARGB(255, 143, 204, 254),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: 0.75,
                              strokeWidth: 15,
                              color: Colors.blue,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                text: "75%",
                                fontWeight: FontWeight.bold,
                                size: 40,
                                color: Color.fromARGB(255, 255, 106, 95),
                              ),
                              SizedBox(height: 8),
                              CustomText(
                                text: "Budget used",
                                fontWeight: FontWeight.bold,
                                size: 22,
                                color: Color.fromARGB(255, 255, 106, 95),
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
                        CustomButton(fontsize: 14,buttonName: "+ Budget", color: Colors.blue, width: 70, height: 30, onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>Wallet()));},),
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
                    TypeDropDown(monthEnable: true, text: "Select Month",onChanged: (){},),
                    const SizedBox(height: 20),
                    // 🔸 Budget + Edit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: "Total Budget (January)",
                          fontWeight: FontWeight.w500,
                          size: 20,
                          color: Colors.blue,
                        ),
                        CustomButton(
                          buttonName: "Edit",
                          fontsize: 17,
                          color: Colors.blue,
                          width: 60,
                          height: 30,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const CustomText(
                      text: "₹ 12,500.00",
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "₹ 9000.00",
                          fontWeight: FontWeight.w500,
                          size: 25,
                          color: Color.fromARGB(255, 250, 105, 105),
                        ),
                        CustomText(
                          text: "₹ 2500.00",
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

                    const ReadMoreText(
                      'Creating a budget helps track income and expenses effectively.It allows individuals to prioritize savings and avoid unnecessary spending.By setting monthly limits, budgeting builds financial discipline and awareness.Over time, it can reveal spending patterns and areas for improvement.A well-planned budget acts as a roadmap toward financial goals and stability.',
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
