import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class RecipeDetailInstructionsSection extends StatelessWidget {
  final String instructionUrl;
  final List<String> instructions;
  const RecipeDetailInstructionsSection(
      {super.key, required this.instructionUrl, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 550,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: 200.0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    instructionUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemCount: instructions.length,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Expanded(
                          child: Text(
                            instructions[index],
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
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
