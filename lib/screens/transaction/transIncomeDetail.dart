import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:readmore/readmore.dart';

class TransIncomeDetail extends StatefulWidget {
  final String category;
  final String transType;
  final String date;
  final double amount;
  final Color amountColor;
  final String note;

  const TransIncomeDetail({
    super.key,
    required this.amount,
    required this.category,
    required this.date,
    required this.transType,
    required this.amountColor,
    required this.note,
  });

  @override
  State<TransIncomeDetail> createState() => _TransIncomeDetailState();
}

class _TransIncomeDetailState extends State<TransIncomeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Transaction details',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 26),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 🔹 Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://imgs.search.brave.com/zBpotWQLBykUvnp_zyXFgHAXCW0UVDB-7a4_AK8maMI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2NmLzQy/LzJiL2NmNDIyYjI4/ZmNkN2VmNzdlYTc5/NWEzZGY2ZTkzZGI3/LmpwZw"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 Scrollable content with white card
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 120, left: 16, right: 16, bottom: 40),
              child: Container(
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
                    Center(
                        child: CustomText(
                            text: widget.category,
                            fontWeight: FontWeight.bold,
                            size: 30)),
                    Center(
                        child: CustomText(
                            text: "(${widget.transType})",
                            fontWeight: FontWeight.w400,
                            size: 22,
                            color: widget.amountColor)),
                    const SizedBox(height: 20),
                    const CustomText(
                        text: "Transaction Details :",
                        fontWeight: FontWeight.w600,
                        size: 20,
                        color: Color.fromARGB(255, 108, 107, 107)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                            text: "Status",
                            fontWeight: FontWeight.w400,
                            size: 20,
                            color: Color.fromARGB(255, 108, 107, 107)),
                        CustomText(
                            text: widget.transType,
                            fontWeight: FontWeight.w500,
                            size: 17,
                            color: widget.amountColor),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                            text: "From",
                            fontWeight: FontWeight.w400,
                            size: 20,
                            color: Color.fromARGB(255, 108, 107, 107)),
                        CustomText(
                            text: widget.category,
                            fontWeight: FontWeight.w500,
                            size: 17,
                            color: Colors.black),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                            text: "Date",
                            fontWeight: FontWeight.w400,
                            size: 20,
                            color: Color.fromARGB(255, 108, 107, 107)),
                        CustomText(
                            text: widget.date,
                            fontWeight: FontWeight.w500,
                            size: 17,
                            color: Colors.black),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const CustomText(
                            text: "Note : ",
                            fontWeight: FontWeight.w400,
                            size: 20,
                            color: Color.fromARGB(255, 108, 107, 107)),
                   // const SizedBox(: 10),
                     Expanded(
                       child: ReadMoreText(
                        widget.note,
                        trimLines: 2,
                        colorClickableText: Colors.blue,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Read More',
                        trimExpandedText: 'Read Less',
                        style: const TextStyle(fontSize: 19),
                        moreStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                        lessStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                                           ),
                     ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                            text: "Total",
                            fontWeight: FontWeight.w400,
                            size: 20,
                            color: Color.fromARGB(255, 108, 107, 107)),
                        CustomText(
                            text: "₹ ${(widget.amount).toString()}",
                            fontWeight: FontWeight.w500,
                            size: 17,
                            color: widget.amountColor),
                      ],
                    ),
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
