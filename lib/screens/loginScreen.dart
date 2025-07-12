import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finance_tracker_frontend/screens/bottombar.dart';
import 'package:finance_tracker_frontend/screens/signUpScreen.dart';
import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/customButton.dart';
import 'package:finance_tracker_frontend/widgets/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  String tokens = "";
  Map resData = {};
  Future<void> login() async {
    const String uri = "http://192.168.1.4:4000/api/users/login";
    final url = Uri.parse(uri);
    if (emailController.text.isEmpty || passController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "email": emailController.text,
          "password": passController.text,
        }));
    resData = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resData["message"] ?? 'Login successful!'),
          duration: Duration(seconds: 1)
        ),
      );
      try {
        tokens = resData["Token"];
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', tokens);
        log(tokens);
      } catch (e) {
        log("Error saving token: $e");
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const BottomBar()));
      log(response.body);
    } else {
      log(resData["message"]);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resData["message"] ?? 'Login failed!❌ ❌ '),duration: Duration(seconds: 1),),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                //height: 200,
                width: 400,
                child: Image.asset(
                  "assets/18377.png",
                  fit: BoxFit.cover,
                )),
            const CustomText(
                text: "Email",
                fontWeight: FontWeight.w500,
                size: 18,
                color: Colors.black),
            const SizedBox(height: 5),
            CustomTextField(
              controller: emailController,
              hintText: "Enter your email",
            ),
            const SizedBox(height: 20),
            const CustomText(
                text: "Password",
                fontWeight: FontWeight.w500,
                size: 18,
                color: Colors.black),
            const SizedBox(height: 5),
            CustomTextField(
              controller: passController,
              hintText: "Enter your password",
            ),
            const SizedBox(height: 30),
            Center(
                child: CustomButton(
                    buttonName: "Login",
                    color: Colors.blue,
                    width: 300,
                    height: 50,
                    onTap: () async {
                      await login();
                    })),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                    text: "Don't have any account? ",
                    fontWeight: FontWeight.w500,
                    size: 16,
                    color: Colors.black),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const CustomText(
                        text: "Sign Up",
                        fontWeight: FontWeight.w500,
                        size: 16,
                        color: Colors.blue)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
