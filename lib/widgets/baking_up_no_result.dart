import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class BakingUpNoResult extends StatelessWidget {
  final String message;
  const BakingUpNoResult({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/icons/no-results.png',
          height: 150,
          width: 150,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          message,
          style: TextStyle(
            fontSize: 16,
            color: darkGreyColor,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
