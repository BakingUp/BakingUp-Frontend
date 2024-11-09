import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NotificationMessageSectionLoading extends StatelessWidget {
  const NotificationMessageSectionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              width: 100,
              height: 15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13), color: whiteColor),
            )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: whiteColor),
                )),
            Shimmer.fromColors(
              baseColor: greyColor,
              highlightColor: whiteColor,
              child: Container(
                width: 250,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13), color: whiteColor),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
