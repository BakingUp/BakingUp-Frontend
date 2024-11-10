import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class AddEditIngredientStockTextField extends StatelessWidget {
  final String label;
  final double width;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onTextChanged;
  const AddEditIngredientStockTextField({
    super.key,
    required this.label,
    required this.width,
    required this.controller,
    required this.focusNode,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 45,
      child: TextField(
        onChanged: (_) => onTextChanged(),
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
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
