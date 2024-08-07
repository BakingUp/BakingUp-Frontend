import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:flutter/material.dart';

class BakingUpLongActionButton extends StatelessWidget {
  final String title;
  final Color color;
  final double? width;
  final BakingUpDialogParams? dialogParams;
  const BakingUpLongActionButton(
      {super.key,
      required this.title,
      required this.color,
      this.width,
      this.dialogParams});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(50),
      child: GestureDetector(
        onTap: () {
          if (dialogParams != null) {
            showDialog(
              context: context,
              barrierColor: const Color(0xC7D9D9D9),
              builder: (BuildContext context) {
                return BakingUpDialog(
                  title: dialogParams!.title,
                  imgUrl: dialogParams!.imgUrl,
                  content: dialogParams!.content,
                  grayButtonTitle: dialogParams!.grayButtonTitle,
                  secondButtonTitle: dialogParams?.secondButtonTitle,
                  secondButtonColor: dialogParams?.secondButtonColor,
                );
              },
            );
          }
        },
        child: Container(
          width: width ?? 150,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class BakingUpDialogParams {
  final String title;
  final String imgUrl;
  final String content;
  final String grayButtonTitle;
  final String? secondButtonTitle;
  final Color? secondButtonColor;

  BakingUpDialogParams({
    required this.title,
    required this.imgUrl,
    required this.content,
    required this.grayButtonTitle,
    this.secondButtonTitle,
    this.secondButtonColor,
  });
}
