import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class StockDetailContainer extends StatelessWidget {
  final Widget child;

  const StockDetailContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.width / 1.5,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 20,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: child,
      ),
    );
  }
}
