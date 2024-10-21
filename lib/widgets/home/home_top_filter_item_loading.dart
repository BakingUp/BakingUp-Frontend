import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeTopFilterItemLoading extends StatelessWidget {
  const HomeTopFilterItemLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
        child: Row(children: [
          Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: whiteColor,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Row(children: [
            Shimmer.fromColors(
              baseColor: greyColor,
              highlightColor: whiteColor,
              child: Container(
                width: 100,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 16.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: greyColor,
                  highlightColor: whiteColor,
                  child: Container(
                    height: 20,
                    width: 150,
                    color: whiteColor,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                ),
                Shimmer.fromColors(
                  baseColor: greyColor,
                  highlightColor: whiteColor,
                  child: Container(
                    height: 10,
                    width: 100,
                    color: whiteColor,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 1.0),
                ),
              ],
            ),
          ])
        ]));
  }
}
