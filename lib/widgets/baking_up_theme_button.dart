import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.color,
    required this.text,
    required this.onTap,
    this.paddingHorizontal,
  });

  final String color;
  final String text;
  final Function()? onTap;
  final EdgeInsetsGeometry? paddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          gradient: onTap == null
              ? null
              : color == "primary"
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        darkBrownColor,
                        darkBrownColor.withOpacity(0.7),
                      ],
                    )
                  : null,
          color: onTap == null
              ? Colors.grey[300]
              : color == "primary"
                  ? null
                  : greyColor,
        ),
        child: Center(
          child: Container(
            padding: paddingHorizontal,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: onTap == null 
                    ? Colors.grey[600]
                    : color == "primary"
                        ? Colors.white
                        : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}