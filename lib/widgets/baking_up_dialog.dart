import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/baking_up_long_action_button.dart';
import 'package:flutter/material.dart';

class BakingUpDialog extends StatelessWidget {
  final String title;
  final String imgUrl;
  final String content;
  final String grayButtonTitle;
  final String? secondButtonTitle;
  final Color? secondButtonColor;
  const BakingUpDialog({
    super.key,
    required this.title,
    required this.imgUrl,
    required this.content,
    required this.grayButtonTitle,
    this.secondButtonTitle,
    this.secondButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierColor: const Color(0xC7D9D9D9),
        builder: (BuildContext context) {
          return AlertDialog(
            content: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    imgUrl,
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BakingUpLongActionButton(
                          title: grayButtonTitle, color: greyColor, width: 120),
                      const SizedBox(width: 8),
                      secondButtonTitle != null &&
                              secondButtonTitle?.isNotEmpty == true
                          ? BakingUpLongActionButton(
                              title: secondButtonTitle!,
                              color: secondButtonColor ?? lightGreenColor,
                              width: 120)
                          : Container()
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(),
    );
  }
}
