import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:flutter/material.dart';

class IngredientDetailScreen extends StatefulWidget {
  const IngredientDetailScreen({super.key});

  @override
  State<IngredientDetailScreen> createState() => _IngredientDetailScreenState();
}

class _IngredientDetailScreenState extends State<IngredientDetailScreen> {
  final int _currentDrawerIndex = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("BakingUp"),
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
        body: const Text("Ingredient"));
  }
}
