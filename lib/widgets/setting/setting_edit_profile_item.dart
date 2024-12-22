import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SettingEditProfileItem extends StatefulWidget {
  final bool isLoading;
  final TextEditingController text;
  final String label;
  const SettingEditProfileItem(
      {super.key,
      required this.isLoading,
      required this.text,
      required this.label});

  @override
  State<SettingEditProfileItem> createState() => _SettingEditProfileItemState();
}

class _SettingEditProfileItemState extends State<SettingEditProfileItem> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: 100,
                  height: 16,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 7.0),
                ),
              ),
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: 200,
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 7.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    '${widget.label}: ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  widget.label == "Firstname" || widget.label == "Lastname"
                      ? Text(
                          '*',
                          style: TextStyle(
                            color: redColor,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(width: 8),
                ],
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 55,
                  child: TextField(
                    cursorColor: blackColor,
                    maxLines: 1,
                    enabled: widget.label != "Email",
                    controller: widget.text,
                    decoration: InputDecoration(
                      fillColor:
                          widget.label == "Email" ? greyColor : Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: darkGreyColor, width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: darkGreyColor, width: 0.5),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  )),
            ],
          );
  }
}
