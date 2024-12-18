import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_scale_dialog.dart';
import 'package:flutter/material.dart';

class RecipeDetailScaleButton extends StatelessWidget {
  final int servings;
  final FocusNode focusNode;
  final Function(String) onScale;
  final VoidCallback onDismissed;
  const RecipeDetailScaleButton({
    super.key,
    required this.servings,
    required this.focusNode,
    required this.onScale,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: 50,
        height: 50,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierColor: const Color(0xC7D9D9D9),
              builder: (BuildContext context) {
                return RecipeDetailScaleDialog(
                  servings: servings,
                  focusNode: focusNode,
                  onScale: (String scale) {
                    onScale(scale);
                  },
                  onDismissed: onDismissed,
                );
              },
            );
          },
          heroTag: 'add',
          backgroundColor: lightYellowColor,
          elevation: 5,
          shape: const CircleBorder(),
          child: Image.asset(
            'assets/icons/scale.png',
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }
}
