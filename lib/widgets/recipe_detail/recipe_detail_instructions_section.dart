import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/recipe_detail/recipe_detail_instructions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailInstructionsSection extends StatelessWidget {
  final String instructionUrl;
  final List<String> instructions;
  final bool isLoading;
  const RecipeDetailInstructionsSection({
    super.key,
    required this.instructionUrl,
    required this.instructions,
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
                  SizedBox(
                    width: double.infinity,
                    height: 200.0,
                    child: !isLoading
                        ? Image.network(
                            instructionUrl,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                  ),
                  const SizedBox(height: 30),
                  RecipeDetailInstructions(
                    instructions: instructions,
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
