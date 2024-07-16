import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/expiration_status.dart';
import 'package:flutter/material.dart';

class ExpirationStatusIndicator extends StatelessWidget {
  final ExpirationStatus status;

  const ExpirationStatusIndicator({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: status == ExpirationStatus.black
            ? blackColor
            : status == ExpirationStatus.red
                ? redColor
                : status == ExpirationStatus.yellow
                    ? yellowColor
                    : greenColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
