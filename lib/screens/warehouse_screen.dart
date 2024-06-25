import 'package:bakingup_frontend/utilities/drawer.dart';
import 'package:flutter/material.dart';

class WarehouseScreen extends StatefulWidget {
  const WarehouseScreen({super.key});

  @override
  State<WarehouseScreen> createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  final int _currentDrawerIndex = 3;
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
        body: const Text("Warehouse"));
  }
}
