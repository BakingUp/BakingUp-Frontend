import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/baking_up_image_picker_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BakingUpImagePicker extends StatelessWidget {
  const BakingUpImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BakingUpImagePickerBottomSheet.show(context);
      },
      child: Container(
        color: greyColor,
        margin: const EdgeInsets.all(12.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 2,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize
                  .min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Add image",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(width: 4),
                Image.asset('assets/icons/add.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
