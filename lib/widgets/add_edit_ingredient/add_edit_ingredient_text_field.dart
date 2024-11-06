import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEditIngredientTextField extends StatefulWidget {
  final TextEditingController controller;
  final int lengthLimit;
  final int min;
  final int max;
  final VoidCallback onTextChanged;
  const AddEditIngredientTextField({
    super.key,
    required this.controller,
    required this.lengthLimit,
    required this.min,
    required this.max,
    required this.onTextChanged,
  });

  @override
  State<AddEditIngredientTextField> createState() =>
      _AddEditIngredientTextFieldState();
}

class _AddEditIngredientTextFieldState
    extends State<AddEditIngredientTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    widget.onTextChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: widget.controller,
        maxLines: 1,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(widget.lengthLimit),
          CustomRangeTextInputFormatter(widget.min, widget.max),
        ],
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

class CustomRangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  CustomRangeTextInputFormatter(this.min, this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final int value = int.parse(newValue.text);
    if (value < min || value > max) {
      return oldValue;
    }
    return newValue;
  }
}
