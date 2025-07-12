import 'dart:convert';
import 'dart:developer';
import 'package:finance_tracker_frontend/screens/loginScreen.dart';
import 'package:finance_tracker_frontend/widgets/CustomText.dart';
import 'package:finance_tracker_frontend/widgets/customButton.dart';
import 'package:finance_tracker_frontend/widgets/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  Map resData = {};

  Future<void> createAccount() async {
    const String uri = "http://192.168.1.4:4000/api/users/register";
    final url = Uri.parse(uri);
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passController.text.isEmpty) {
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
          "username": nameController.text,
          "email": emailController.text,
          "password": passController.text,
        }));
    log(response.statusCode.toString());

    log(response.body);
    //if (response.statusCode == 400) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      resData = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: 30),
            content: Text(
              resData["message"] ?? 'Account created successfully!',
            )),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(resData["message"] ?? 'Failed to create account')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: 400,
                  child: Image.asset(
                    "assets/18377.png",
                    fit: BoxFit.cover,
                  )),
              const CustomText(
                  text: "Name",
                  fontWeight: FontWeight.w500,
                  size: 18,
                  color: Colors.black),
              const SizedBox(height: 5),
              CustomTextField(
                controller: nameController,
                hintText: "Enter your email",
              ),
              const SizedBox(height: 20),
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
                      buttonName: "Create Account",
                      color: Colors.blue,
                      width: 300,
                      height: 50,
                      onTap: () async {
                        await createAccount();
                      })),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                      text: "Already have an account? ",
                      fontWeight: FontWeight.w500,
                      size: 16,
                      color: Colors.black),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: CustomText(
                          text: "Login",
                          fontWeight: FontWeight.w500,
                          size: 16,
                          color: Colors.blue)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
