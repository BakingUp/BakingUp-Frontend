import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/baking_up_dropdown_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BakingUpDropdown extends StatelessWidget {
  final List<String> options;
  final String topic;
  final String selectedOption;
  final Function(String) onApply;
  const BakingUpDropdown({
    super.key,
    required this.options,
    required this.topic,
    required this.selectedOption,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          backgroundColor: backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          builder: (BuildContext context) {
            return BakingUpDropdownBottomSheet(
              options: options,
              topic: topic,
              selectedOption: selectedOption,
              onApply: onApply,
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: lightGreyColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Text(
              selectedOption.isEmpty ? 'select' : selectedOption,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
