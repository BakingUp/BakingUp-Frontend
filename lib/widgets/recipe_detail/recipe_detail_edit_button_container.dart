import 'package:flutter/widgets.dart';

class RecipeDetailEditButtonContainer extends StatelessWidget {
  final List<Widget> children;
  const RecipeDetailEditButtonContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      right: 20,
      child: Row(
        children: [
          ...children,
        ],
      ),
    );
  }
}
