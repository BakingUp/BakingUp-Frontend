import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class BakingUpSearchBar extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  const BakingUpSearchBar(
      {super.key, this.hintText, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: controller,
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
            contentPadding: const EdgeInsets.only(
                bottom: 40.0), // Adjust the vertical padding as needed
            hintStyle: const TextStyle(
                fontSize: 12.0), // Adjust the font size as needed
          ),
        ),
      ),
    );
  }
}
