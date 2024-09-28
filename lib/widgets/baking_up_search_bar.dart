import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class BakingUpSearchBar extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  const BakingUpSearchBar(
      {super.key,
      this.hintText,
      this.controller,
      this.onChanged,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: TextField(
          autofocus: false,
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText ?? 'Search',
            filled: true,
            fillColor: greyColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.search),
            contentPadding: const EdgeInsets.only(bottom: 40.0),
            hintStyle: const TextStyle(fontSize: 12.0),
          ),
        ),
      ),
    );
    // );
  }
}
