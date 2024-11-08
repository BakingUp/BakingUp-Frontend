import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecipeDetailScaleDialog extends StatefulWidget {
  final int servings;
  final FocusNode focusNode;
  final Function(String) onScale;
  final VoidCallback onDismissed;
  const RecipeDetailScaleDialog(
      {super.key,
      required this.servings,
      required this.focusNode,
      required this.onScale,
      required this.onDismissed});

  @override
  State<RecipeDetailScaleDialog> createState() =>
      _RecipeDetailScaleDialogState();
}

class _RecipeDetailScaleDialogState extends State<RecipeDetailScaleDialog> {
  final TextEditingController _scaleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: GestureDetector(
        onTap: () {
          widget.onDismissed();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Scale Recipe",
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
                              controller: _scaleController,
                              focusNode: widget.focusNode,
                              onChanged: (value) {
                                setState(() {});
                              },
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w300,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CustomRangeTextInputFormatter(1, 99999),
                              ],
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
                        'Baseline Servings: ${widget.servings}',
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
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      BakingUpLongActionButton(
                        title: "Confirm",
                        color: _scaleController.text.isEmpty
                            ? greyColor
                            : lightGreenColor,
                        width: 120,
                        isDisabled: _scaleController.text.isEmpty,
                        onClick: () {
                          widget.onScale(_scaleController.text);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
