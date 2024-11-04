import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:flutter/material.dart';

class RecipeDetailScaleDialog extends StatelessWidget {
  final int servings;
  const RecipeDetailScaleDialog({
    super.key,
    required this.servings,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Scale Recipes",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Image.asset("assets/icons/scale_large.png"),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Servings',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                            color: redColor,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 60,
                          child: TextField(
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                            ),
                            cursorColor: blackColor,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: darkGreyColor, width: 0.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: darkGreyColor, width: 0.5),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Baseline Servings: $servings',
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BakingUpLongActionButton(
                  title: "Cancel",
                  color: greyColor,
                  width: 120,
                  isDisabled: false,
                ),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    BakingUpLongActionButton(
                      title: "Confirm",
                      color: lightGreenColor,
                      width: 120,
                      isDisabled: false,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
