import 'package:flutter/material.dart';

class OrderEditButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const OrderEditButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, 
      child: Image.asset(
        'assets/icons/edit.png',
        width: 20, 
        height: 20,
        fit: BoxFit.contain,
      ),
    );
  }
}
