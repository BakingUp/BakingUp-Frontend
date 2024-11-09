import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_modal_bottom.dart';
import 'package:flutter/material.dart';

class BakingUpFilterButton extends StatelessWidget {
  final List<String> optionsOne;
  final String optionOneName;
  final String defaultFilteringValue;
  final String defaultSortingValue;
  final void Function(String, String) filterFunction;

  const BakingUpFilterButton({
    super.key,
    required this.optionsOne,
    required this.optionOneName,
    required this.defaultFilteringValue,
    required this.defaultSortingValue,
    required this.filterFunction,
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
            return BakingUpFilterModalBottom(
              optionsOne: optionsOne,
              optionOneName: "Filter by",
              defaultFilteringValue: defaultFilteringValue,
              defaultSortingValue: defaultSortingValue,
              filterFunction: filterFunction,
            );
          },
        );
      },
      child: Image.asset('assets/icons/filter.png'),
    );
  }
}
