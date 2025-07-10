import 'package:flutter/material.dart';

class TypeDropDown extends StatefulWidget {
  final bool monthEnable;
  final String text;
  final onChanged;
  const TypeDropDown({super.key,required this.monthEnable, required this.text,required this.onChanged});

  @override
  State<TypeDropDown> createState() => _TypeDropDownState();
}

class _TypeDropDownState extends State<TypeDropDown> {
  final List<String> categories = ['income', 'expense'];
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          hint:  Text(widget.text),
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
              widget.onChanged.call(value);
            });
          },
          items: widget.monthEnable ? months.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList() : categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
        ),
      ),
    );
  }
}
