import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BakingUpError extends StatelessWidget {
  const BakingUpError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Something went wrong :(",
          style: TextStyle(
              fontSize: 32,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Image.asset(
          'assets/icons/error_page.png',
          width: 250,
          height: 250,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'An error has occurred, please refresh your page to re-load the data or go back to your home page.',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          child: Container(
            width: 200,
            height: 40,
            decoration: BoxDecoration(
              color: greyColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Back to the home page',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        )
      ],
    );
  }
}
