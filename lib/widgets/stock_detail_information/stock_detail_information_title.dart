import 'package:flutter/material.dart';

class StockDetailInformationTitle extends StatelessWidget {
  final String title;
  const StockDetailInformationTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
