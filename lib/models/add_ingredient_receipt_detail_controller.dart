import 'package:flutter/material.dart';

class AddIngredientReceiptDetailController {
    final TextEditingController engNameController = TextEditingController();
    final TextEditingController thaiNameController = TextEditingController();
    final TextEditingController brandController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController supplierController = TextEditingController();
    final TextEditingController expirationDateController = TextEditingController();
    final TextEditingController ingredientLessThanController = TextEditingController();
    final TextEditingController daysBeforeExpireController = TextEditingController();
    final TextEditingController noteController = TextEditingController();

    String get engName => engNameController.text;
    set engName(String value) => engNameController.text = value;

    String get thaiName => thaiNameController.text;
    set thaiName(String value) => thaiNameController.text = value;

    String get brand => brandController.text;
    set brand(String value) => brandController.text = value;

    String get quantity => quantityController.text;
    set quantity(String value) => quantityController.text = value;

    String get price => priceController.text;
    set price(String value) => priceController.text = value;

    String get supplier => supplierController.text;
    set supplier(String value) => supplierController.text = value;

    String get expirationDate => expirationDateController.text;
    set expirationDate(String value) => expirationDateController.text = value;

    String get ingredientLessThan => ingredientLessThanController.text;
    set ingredientLessThan(String value) => ingredientLessThanController.text = value;

    String get daysBeforeExpire => daysBeforeExpireController.text;
    set daysBeforeExpire(String value) => daysBeforeExpireController.text = value;

    String get note => noteController.text;
    set note(String value) => noteController.text = value;

    void dispose() {
        engNameController.dispose();
        thaiNameController.dispose();
        brandController.dispose();
        quantityController.dispose();
        priceController.dispose();
        supplierController.dispose();
        expirationDateController.dispose();
        ingredientLessThanController.dispose();
        daysBeforeExpireController.dispose();
        noteController.dispose();
    }
}