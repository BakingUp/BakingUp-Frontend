import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class RecipeDetailTabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onClick;
  const RecipeDetailTabButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: isSelected ? lightYellowColor : greyColor,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow
                      .visible,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          onClick();
        },
      ),
    );
  }
}
