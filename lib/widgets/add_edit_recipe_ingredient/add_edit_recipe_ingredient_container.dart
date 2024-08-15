import 'package:flutter/material.dart';

class AddEditRecipeIngredientContainer extends StatelessWidget {
  final List<Widget> children;
  const AddEditRecipeIngredientContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          ...children,
        ],
      ),
    );
  }
}
