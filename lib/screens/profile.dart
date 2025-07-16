import 'dart:ui';

import 'package:finance_tracker_frontend/screens/loginScreen.dart';
import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
void logoutUser(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => DialogBox(
      button1: "Log Out",
      button2: "Cancel",
      title: "Log Out",
      message: "Are you sure you want to log out from the app?",
      onTap1: ()async {
        Navigator.pop(context);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove("token");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginScreen()), (route) => false);
        print("User logged out ✅");
      },
      onTap2: () {
        Navigator.pop(context);
      },
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 🔹 Allows body to go behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 🔹 Makes AppBar see-through
        elevation: 0, // 🔹 Removes shadow
        title: const Text(
          'Profile',
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
                  "https://imgs.search.brave.com/zBpotWQLBykUvnp_zyXFgHAXCW0UVDB-7a4_AK8maMI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2NmLzQy/LzJiL2NmNDIyYjI4/ZmNkN2VmNzdlYTc5/NWEzZGY2ZTkzZGI3/LmpwZw",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground Content
           Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
                const Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_2_rounded,
                      size: 80,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomText(
                    text: "Shiwang Chaudhary",
                    fontWeight: FontWeight.w500,
                    size: 23),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {   
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.person_3,
                        size: 45,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      CustomText(
                          text: "Account info",
                          fontWeight: FontWeight.w500,
                          size: 23),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {   
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.message_outlined,
                        size: 45,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      CustomText(
                          text: "Message centre",
                          fontWeight: FontWeight.w500,
                          size: 23),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {   
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 45,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      CustomText(
                          text: "Data and Privacy",
                          fontWeight: FontWeight.w500,
                          size: 23),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {   
                    logoutUser(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout,
                        size: 45,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      CustomText(
                          text: "Log out",
                          fontWeight: FontWeight.w500,
                          size: 23,
                          color: Colors.red,),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),

          // Floating Card with total balance
        ],
      ),
    );
  }
}
