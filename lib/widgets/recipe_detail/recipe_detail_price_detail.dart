import 'package:flutter/material.dart';

class RecipeDetailPriceDetail extends StatelessWidget {
  final Color color;
  final String header;
  final double price;

  const RecipeDetailPriceDetail(
      {super.key,
      required this.color,
      required this.header,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 120,
          child: Text(
            header,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 30,
          child: Text(
            "$price ฿",
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
