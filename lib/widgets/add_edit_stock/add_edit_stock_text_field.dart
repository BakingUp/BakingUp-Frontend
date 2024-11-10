import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class AddEditStockTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onTextChanged;
  const AddEditStockTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        onChanged: (value) => onTextChanged(),
        focusNode: focusNode,
        controller: controller,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'Inter',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w300,
        ),
        cursorColor: blackColor,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkGreyColor, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkGreyColor, width: 0.5),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
