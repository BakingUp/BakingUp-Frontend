import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:flutter/material.dart';

class BakingUpLongActionButton extends StatelessWidget {
  final String title;
  final Color color;
  final double? width;
  final BakingUpDialogParams? dialogParams;
  final VoidCallback? onClick;
  final bool isDisabled;
  const BakingUpLongActionButton({
    super.key,
    required this.title,
    required this.color,
    this.width,
    this.dialogParams,
    this.onClick,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(50),
      child: GestureDetector(
        onTap: () {
          if (dialogParams != null && onClick == null && !isDisabled) {
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
                  grayButtonOnClick: dialogParams?.grayButtonOnClick,
                  secondButtonOnClick: dialogParams?.secondButtonOnClick,
                );
              },
            );
          } else if (onClick != null && dialogParams == null && !isDisabled) {
            onClick!();
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
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              color: isDisabled ? darkGreyColor : blackColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
