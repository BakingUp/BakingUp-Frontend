import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class BakingUpLoadingDialog extends StatelessWidget {
  const BakingUpLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 60),
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(color: darkGreyColor),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
