import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/home.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeTopFilterItem extends StatelessWidget {
  final List<TopProductItem> topProductList;
  final int index;
  final bool isLoading;
  const HomeTopFilterItem({
    super.key,
    required this.topProductList,
    required this.index,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
        child: Row(
          children: [
            Text(
              "#${index + 1}",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                color: blackColor,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Stack(
              children: [
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
                Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.network(
                      topProductList[index].url,
                      width: 100,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 16.0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topProductList[index].name,
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                      ),
                      Text(
                        topProductList[index].detail,
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 1.0),
                      ),
                    ],
                  ),
                ])
              ],
            ),
          ],
        ));
  }
}
