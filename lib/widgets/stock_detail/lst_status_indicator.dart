import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/lst_status.dart';
import 'package:flutter/material.dart';

class LSTStatusIndicator extends StatelessWidget {
  final LSTStatus status;

  const LSTStatusIndicator({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: status == LSTStatus.black
            ? blackColor
            : status == LSTStatus.red
                ? redColor
                : status == LSTStatus.yellow
                    ? yellowColor
                    : greenColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
