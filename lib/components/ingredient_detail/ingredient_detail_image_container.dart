import 'package:flutter/material.dart';

class IngredientDetailImageContainer extends StatelessWidget {
  final Widget child;

  const IngredientDetailImageContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: child,
    );
  }
}
