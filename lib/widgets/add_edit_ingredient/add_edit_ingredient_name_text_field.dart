import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEditIngredientNameTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onTextChanged;
  final FocusNode focusNode;
  const AddEditIngredientNameTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.onTextChanged,
  });

  @override
  State<AddEditIngredientNameTextField> createState() =>
      _AddEditIngredientNameTextFieldState();
}

class _AddEditIngredientNameTextFieldState
    extends State<AddEditIngredientNameTextField> {
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
      width: MediaQuery.of(context).size.width / 2,
      height: 45,
      child: TextField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        maxLines: 1,
        inputFormatters: [
          LengthLimitingTextInputFormatter(99),
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
          labelText: widget.label,
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
