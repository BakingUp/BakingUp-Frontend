import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileTitle extends StatelessWidget {
  final bool isLoading;
  final String firstName;
  final String lastName;

  const ProfileTitle(
      {super.key,
      required this.isLoading,
      required this.firstName,
      required this.lastName});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Row(
            children: [
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: 60,
                  height: 24,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 7.0),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$firstName ${lastName[0]}.',
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
  }
}
