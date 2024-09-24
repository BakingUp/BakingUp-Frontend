import 'package:flutter/material.dart';

class BakingUpFilterModalBottom extends StatefulWidget {
  final List<String> optionsOne;
  final String optionOneName;
  final String defaultFilteringValue;
  final String defaultSortingValue;
  final Function filterFunction;
  const BakingUpFilterModalBottom(
      {super.key,
      required this.optionsOne,
      required this.optionOneName,
      required this.defaultFilteringValue,
      required this.defaultSortingValue,
      required this.filterFunction});

  @override
  State<BakingUpFilterModalBottom> createState() =>
      _WarehouseIngredientFilterState();
}

class _WarehouseIngredientFilterState extends State<BakingUpFilterModalBottom> {
  String? selectedFiltering;
  String? selectedSorting;
  // List of names to display
  // final List<String> filterBy = ['Stock Name', 'Quantity', 'Expiration Date'];
  final List<String> sortBy = ['Ascending Order', 'Descending Order'];
  List<String> name = [];
  String selectFilterType = "";

  @override
  void initState() {
    setState(() {
      name = widget.optionsOne;
      selectFilterType = widget.optionOneName;
      selectedFiltering = widget.defaultFilteringValue;
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
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Color.fromRGBO(255, 255, 255, 1)),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Filters",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
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
                  const Divider(
                    color: Color.fromRGBO(217, 217, 217, 0.78),
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectFilterType = widget.optionOneName;
                                name = widget.optionsOne;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                widget.optionOneName,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    color: selectFilterType ==
                                            widget.optionOneName
                                        ? const Color.fromRGBO(56, 142, 60, 1)
                                        : Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 2.0,
                            color: selectFilterType == widget.optionOneName
                                ? const Color.fromRGBO(56, 142, 60, 1)
                                : const Color.fromRGBO(217, 217, 217, 0.78),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectFilterType = "Sort by";
                                name = sortBy;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                "Sort by",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    color: selectFilterType == "Sort by"
                                        ? const Color.fromRGBO(56, 142, 60, 1)
                                        : Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 2.0,
                            color: selectFilterType == "Sort by"
                                ? const Color.fromRGBO(56, 142, 60, 1)
                                : const Color.fromRGBO(217, 217, 217, 0.78),
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
                    children: name.map((name) {
                      bool isSelected;
                      selectFilterType == widget.optionOneName
                          ? isSelected = name == selectedFiltering
                          : isSelected = name == selectedSorting;
                      return RadioListTile<String>(
                        title: Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                            color: isSelected
                                ? const Color.fromRGBO(56, 142, 60, 1)
                                : Colors.black,
                          ),
                        ),
                        value: name,
                        groupValue: selectFilterType == widget.optionOneName
                            ? selectedFiltering
                            : selectedSorting,
                        onChanged: (String? value) {
                          setState(() {
                            if (selectFilterType == widget.optionOneName) {
                              selectedFiltering = value;
                            } else {
                              selectedSorting = value;
                            }
                          });
                        },
                        activeColor: const Color.fromRGBO(56, 142, 60, 1),
                      );
                    }).toList(),
                  ))),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(200, 230, 201, 1),
                  minimumSize: const Size(200, 40),
                ),
                onPressed: () {
                  widget.filterFunction(selectedFiltering, selectedSorting);
                  Navigator.of(context).pop();
                },
                child: const Center(
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
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
