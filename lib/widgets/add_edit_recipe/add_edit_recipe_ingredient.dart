import 'package:bakingup_frontend/screens/add_recipe_screen.dart';
import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddEditRecipeIngredient extends StatelessWidget {
  final List<RecipeIngredient> recipeIngredients;
  final int index;

  const AddEditRecipeIngredient({
    super.key,
    required this.recipeIngredients,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
      decoration: BoxDecoration(
        color: beigeColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.network(
                  "${dotenv.env['API_BASE_URL']}/${recipeIngredients[index].imgUrl}",
                  width: 90,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/icons/no-image.jpg',
                      width: 90,
                      height: 60,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 16.0)),
            ],
          ),
          Expanded(
            child: Text(
              recipeIngredients[index].name,
              style: TextStyle(
                color: blackColor,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20.0)),
              Text(
                "${recipeIngredients[index].quantity} ${recipeIngredients[index].unit}",
                style: TextStyle(
                  color: blackColor,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 20.0)),
            ],
          )
        ],
      ),
    );
  }
}
