import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_instruction_images.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_instructions.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 550,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: whiteColor,
                child: Container(
                  width: double.infinity,
                  height: 200.0,
                  color: Colors.white,
                ),
              ),
              Column(
                children: [
                  RecipeDetailInstructionImages(
                    imageUrl: instructionUrls,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 30),
                  RecipeDetailInstructions(
                    instructionSteps: instructionSteps,
                    isLoading: isLoading,
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
