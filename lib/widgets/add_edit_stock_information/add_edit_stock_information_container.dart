import 'package:flutter/material.dart';

class AddEditStockInformationContainer extends StatelessWidget {
  final List<Widget> children;
  const AddEditStockInformationContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ...children,
          ],
        ),
      ),
    );
  }
}
