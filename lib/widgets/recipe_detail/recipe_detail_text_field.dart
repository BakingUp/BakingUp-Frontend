import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecipeDetailTextField extends StatefulWidget {
  final double width;
  final TextEditingController controller;
  final double min;
  final double max;
  final FocusNode focusNode;
  final VoidCallback onTextChanged;
  const RecipeDetailTextField({
    super.key,
    required this.width,
    required this.controller,
    required this.min,
    required this.max,
    required this.focusNode,
    required this.onTextChanged,
  });

  @override
  State<RecipeDetailTextField> createState() => _RecipeDetailTextFieldState();
}

class _RecipeDetailTextFieldState extends State<RecipeDetailTextField> {
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
    return SizedBox(
      width: widget.width,
      height: 45,
      child: TextField(
        focusNode: widget.focusNode,
        maxLines: 1,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          CustomRangeTextInputFormatter(widget.min, widget.max),
        ],
        controller: widget.controller,
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

class CustomRangeTextInputFormatter extends TextInputFormatter {
  final double min;
  final double max;

  CustomRangeTextInputFormatter(this.min, this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final double value = double.parse(newValue.text);
    if (value < min || value > max) {
      return oldValue;
    }
    return newValue;
  }
}
