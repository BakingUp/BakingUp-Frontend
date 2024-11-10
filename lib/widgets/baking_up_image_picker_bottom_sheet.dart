import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class BakingUpImagePickerBottomSheet {
  static Future<bool?> show(
    BuildContext context,
    Future<void> Function() onTakePhoto,
    Future<void> Function() onChooseFromGallery,
  ) async {
    return await showModalBottomSheet<bool>(
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
              onTap: () async {
                await onTakePhoto();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(true);
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
              onTap: () async {
                await onChooseFromGallery();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(true);
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
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
