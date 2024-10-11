import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/home/home_top_filter_bottom.dart';
import 'package:flutter/material.dart';

class HomeTopFilterBottomOneOption extends StatefulWidget {
  final String defaultSortingValue;
  final Function filterFunction;
  final String? filterName;
  const HomeTopFilterBottomOneOption(
      {super.key,
      required this.defaultSortingValue,
      required this.filterFunction,
      this.filterName});

  @override
  State<HomeTopFilterBottomOneOption> createState() =>
      _WarehouseIngredientFilterState();
}

class _WarehouseIngredientFilterState
    extends State<HomeTopFilterBottomOneOption> {
  String? selectedFiltering;
  String? selectedSorting;
  final List<String> sortBy = ['Ascending Order', 'Descending Order'];
  List<String> name = [];
  String selectFilterType = "";

  @override
  void initState() {
    setState(() {
      selectedSorting = widget.defaultSortingValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: whiteColor),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: IconButton(
                              onPressed: () {
                                // Close the current BakingUpFilterMultipleModalBottom
                                Navigator.of(context).pop();

                                // Open HomeTopFilterBottom after closing the current modal
                                Future.delayed(
                                    const Duration(milliseconds: 200), () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    backgroundColor: backgroundColor,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40.0),
                                        topRight: Radius.circular(40.0),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.70,
                                          child: DraggableScrollableSheet(
                                            initialChildSize: 1,
                                            minChildSize: 1,
                                            maxChildSize: 1,
                                            builder:
                                                (context, scrollController) {
                                              return HomeTopFilterBottom(
                                                filterFunction:
                                                    widget.filterFunction,
                                              );
                                            },
                                          ));
                                    },
                                  );
                                });
                              },
                              icon: const Icon(Icons.arrow_back_ios),
                            ),
                          )),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            widget.filterName ?? "Filters",
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.close),
                            ),
                          )),
                    ],
                  ),
                  Divider(
                    color: greyColor,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "Sort by",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  color: selectFilterType == "Sort by"
                                      ? greenColor
                                      : blackColor),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 2.0,
                            color: greenColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
          Expanded(
              child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: sortBy.map((name) {
                      bool isSelected;

                      isSelected = name == selectedSorting;
                      return Material(
                          color: Colors.transparent,
                          child: RadioListTile<String>(
                            title: Text(
                              name,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                color: isSelected ? greenColor : blackColor,
                              ),
                            ),
                            value: name,
                            groupValue: selectedSorting,
                            onChanged: (String? value) {
                              setState(() {
                                selectedSorting = value;
                              });
                            },
                            activeColor: greenColor,
                          ));
                    }).toList(),
                  ))),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightGreenColor,
                  minimumSize: const Size(200, 40),
                ),
                onPressed: () {
                  widget.filterFunction(selectedFiltering, selectedSorting);
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
