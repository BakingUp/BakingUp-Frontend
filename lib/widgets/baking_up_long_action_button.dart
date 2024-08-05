import 'package:flutter/material.dart';

class BakingUpLongActionButton extends StatelessWidget {
  final String title;
  final Color color;
  final double? width;
  const BakingUpLongActionButton(
      {super.key, required this.title, required this.color, this.width});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: width ?? 150,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
