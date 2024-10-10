import 'package:flutter/material.dart';

class AddEditIngredientController {
    final TextEditingController engNameController = TextEditingController();
    final TextEditingController thaiNameController = TextEditingController();
    final TextEditingController ingredientLessThanController = TextEditingController();
    final TextEditingController daysBeforeExpireController = TextEditingController();

    String get engName => engNameController.text;
    set engName(String value) => engNameController.text = value;

    String get thaiName => thaiNameController.text;
    set thaiName(String value) => thaiNameController.text = value;

    String get ingredientLessThan => ingredientLessThanController.text;
    set ingredientLessThan(String value) => ingredientLessThanController.text = value;

    String get daysBeforeExpire => daysBeforeExpireController.text;
    set daysBeforeExpire(String value) => daysBeforeExpireController.text = value;

    void dispose() {
        engNameController.dispose();
        thaiNameController.dispose();
        ingredientLessThanController.dispose();
        daysBeforeExpireController.dispose();
    }
}