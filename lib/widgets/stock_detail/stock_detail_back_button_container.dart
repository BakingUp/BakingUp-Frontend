import 'package:flutter/widgets.dart';

class StockDetailBackButtonContainer extends StatelessWidget {
  final List<Widget> children;
  const StockDetailBackButtonContainer(
      {super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: 20,
      right: 0,
      child: Row(
        children: [
          ...children,
        ],
      ),
    );
  }
}
