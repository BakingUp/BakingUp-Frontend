import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:flutter/material.dart';

class ReceipeDetailScreen extends StatefulWidget {
  const ReceipeDetailScreen({super.key});

  @override
  State<ReceipeDetailScreen> createState() => _ReceipeDetailScreenState();
}

class _ReceipeDetailScreenState extends State<ReceipeDetailScreen> {
  final int _currentDrawerIndex = 5;
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
        body: const Text("Recipe"));
  }
}
