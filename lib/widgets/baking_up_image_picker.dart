import 'dart:io';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/baking_up_image_picker_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BakingUpImagePicker extends StatefulWidget {
  final List<File> images;
  final Function(File) onNewImage;
  final bool? isOneImage;
  final Function(int) onDelete;
  const BakingUpImagePicker({
    super.key,
    required this.images,
    required this.onNewImage,
    this.isOneImage = false,
    required this.onDelete,
  });

  @override
  State<BakingUpImagePicker> createState() => _BakingUpImagePickerState();
}

class _BakingUpImagePickerState extends State<BakingUpImagePicker> {
  final picker = ImagePicker();

  Future takePhoto() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    widget.onNewImage(File(pickedFile!.path));
  }

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    widget.onNewImage(File(pickedFile!.path));
  }

  @override
  Widget build(BuildContext context) {
    return widget.images.isEmpty
        ? GestureDetector(
            onTap: () {
              BakingUpImagePickerBottomSheet.show(
                context,
                takePhoto,
                getImageGallery,
              );
            },
            child: Container(
              color: greyColor,
              margin: const EdgeInsets.all(12.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
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
          )
        : Container(
            height: widget.isOneImage == true
                ? MediaQuery.of(context).size.width / 2
                : 100,
            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 25.0),
            child: widget.isOneImage == true
                ? Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(12.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          image: DecorationImage(
                            image: FileImage(widget.images[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: redColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.remove,
                                size: 15, color: whiteColor, weight: 10),
                            onPressed: () {
                              widget.onDelete(0);
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    itemCount: widget.images.length + 1,
                    itemBuilder: (context, index) {
                      return index != widget.images.length
                          ? Container(
                              margin: EdgeInsets.only(
                                  right: index == widget.images.length - 1
                                      ? 0
                                      : 15),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      image: DecorationImage(
                                        image: FileImage(widget.images[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -5,
                                    right: -5,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: redColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.remove,
                                            size: 15,
                                            color: whiteColor,
                                            weight: 10),
                                        onPressed: () {
                                          widget.onDelete(index);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : widget.images.length < 5
                              ? GestureDetector(
                                  onTap: () {
                                    BakingUpImagePickerBottomSheet.show(
                                      context,
                                      takePhoto,
                                      getImageGallery,
                                    );
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    margin: const EdgeInsets.only(left: 15),
                                    decoration: BoxDecoration(
                                      color: greyColor,
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/icons/add.png',
                                              scale: 0.4),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container();
                    },
                  ),
          );
  }
}
