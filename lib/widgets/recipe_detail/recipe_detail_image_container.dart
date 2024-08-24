import 'package:flutter/material.dart';

class RecipeDetailImageContainer extends StatelessWidget {
  final Widget child;

  const RecipeDetailImageContainer({super.key, required this.child});

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