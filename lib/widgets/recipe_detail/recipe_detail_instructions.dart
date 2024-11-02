import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailInstructions extends StatelessWidget {
  final String instructionSteps;
  final bool isLoading;
  const RecipeDetailInstructions({
    super.key,
    required this.instructionSteps,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: double.infinity,
        child: isLoading
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "• ",
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: greyColor,
                        highlightColor: whiteColor,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 90,
                          height: 13,
                          color: Colors.white,
                        ),
                      )
                    ],
                  );
                },
              )
            : Text(
                instructionSteps,
                style: TextStyle(
                  color: blackColor,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  overflow: TextOverflow.visible,
                ),
              ),
      ),
    );
  }
}
