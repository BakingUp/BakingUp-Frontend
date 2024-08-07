import 'package:bakingup_frontend/widgets/baking_up_dialog.dart';
import 'package:flutter/material.dart';

class IngredientStockDetailDeleteButton extends StatelessWidget {
  final BakingUpDialogParams? dialogParams;
  const IngredientStockDetailDeleteButton({super.key, this.dialogParams});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset('assets/icons/delete.png'),
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
    );
  }
}
