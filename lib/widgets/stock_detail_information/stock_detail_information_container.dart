import 'package:flutter/material.dart';

class StockDetailInformationContainer extends StatelessWidget {
  final List<Widget> children;
  const StockDetailInformationContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
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
