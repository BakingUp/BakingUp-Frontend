import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:flutter/material.dart';

class AddEditIngredientScreen extends StatefulWidget {
  const AddEditIngredientScreen({super.key});

  @override
  State<AddEditIngredientScreen> createState() =>
      _AddEditIngredientScreenState();
}

class _AddEditIngredientScreenState extends State<AddEditIngredientScreen> {
  final int _currentDrawerIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ingredient",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: BakingUpDrawer(
        currentDrawerIndex: _currentDrawerIndex,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Ingredient Information",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Container(
              color: greyColor,
              margin: const EdgeInsets.all(12.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .min, // This makes the Row only take as much space as needed
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Add image",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Image.asset('assets/icons/add.png'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
