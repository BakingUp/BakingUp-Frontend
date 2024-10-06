import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_instruction_images.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_instructions.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_title.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailInstructionsSection extends StatelessWidget {
  final List<String> instructionUrls;
  final List<String> instructionSteps;
  final bool isLoading;
  const RecipeDetailInstructionsSection({
    super.key,
    required this.instructionUrls,
    required this.instructionSteps,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 8),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 550,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: RecipeDetailTitle(title: "Instructions"),
              ),
              Stack(
                children: [
                  if (isLoading || instructionUrls.isNotEmpty) ...[
                    Shimmer.fromColors(
                      baseColor: greyColor,
                      highlightColor: whiteColor,
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  Column(
                    children: [
                      if (instructionUrls.isNotEmpty) ...[
                        RecipeDetailInstructionImages(
                          imageUrl: instructionUrls,
                          isLoading: isLoading,
                        ),
                      ],
                      if (instructionUrls.isNotEmpty &&
                          instructionSteps.isNotEmpty) ...[
                        const SizedBox(height: 30)
                      ],
                      if (instructionSteps.isNotEmpty) ...[
                        RecipeDetailInstructions(
                          instructionSteps: instructionSteps,
                          isLoading: isLoading,
                        ),
                      ]
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
