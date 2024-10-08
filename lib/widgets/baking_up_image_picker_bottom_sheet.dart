import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class BakingUpImagePickerBottomSheet {
  static void show(
    BuildContext context,
    VoidCallback onTakePhoto,
    VoidCallback onChooseFromGallery,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              title: const Center(
                child: Text(
                  'Take Photo',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              onTap: () {
                onTakePhoto();
                Navigator.of(context).pop();
              },
            ),
            Divider(
              height: 1,
              thickness: 2,
              color: greyColor,
            ),
            ListTile(
              title: const Center(
                child: Text(
                  'Choose From Library',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              onTap: () {
                onChooseFromGallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              tileColor: greyColor,
              title: const Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
