import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool showSymbol;
  final bool numberType;
  final int? maxlines;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.showSymbol = false,
    this.numberType = false,
    this.maxlines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxlines ?? 1,
      controller: controller,
      keyboardType: numberType
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text, // ✅ switch based on numberType
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: showSymbol
            ? const Padding(
                padding: EdgeInsets.only(left: 12, right: 8),
                child: Icon(
                  Icons.currency_rupee,
                  size: 20,
                  color: Color.fromARGB(255, 106, 106, 106),
                ),
              )
            : null,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
    );
  }
}
