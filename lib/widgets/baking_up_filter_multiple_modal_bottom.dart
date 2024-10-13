import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/home/home_top_filter_bottom.dart';
import 'package:flutter/material.dart';

class BakingUpFilterMultipleModalBottom extends StatefulWidget {
  final List<Map<String, dynamic>> optionsOne;
  final String optionOneName;
  final List<Map<String, dynamic>> optionsTwo;
  final String optionTwoName;
  final String filterName;
  final Function filterFunction;
  // final Function filterFunction;
  const BakingUpFilterMultipleModalBottom(
      {super.key,
      required this.optionsOne,
      required this.optionOneName,
      required this.optionsTwo,
      required this.optionTwoName,
      required this.filterName,
      required this.filterFunction});

  @override
  State<BakingUpFilterMultipleModalBottom> createState() =>
      _WarehouseIngredientFilterState();
}

class _WarehouseIngredientFilterState
    extends State<BakingUpFilterMultipleModalBottom> {
  String? selectedFiltering;
  String? selectedSorting;
  final List<String> sortBy = ['Ascending Order', 'Descending Order'];
  List<String> name = [];
  String selectFilterType = "";
  List<Map<String, dynamic>> filterFirstOption = [];
  List<Map<String, dynamic>> filterSecondOption = [];

  @override
  void initState() {
    setState(() {
      selectFilterType = widget.optionOneName;
      filterFirstOption = widget.optionsOne;
      filterSecondOption = widget.optionsTwo;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
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
                                Navigator.of(context).pop();

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
                            widget.filterName,
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
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectFilterType = widget.optionOneName;
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
                                    color:
                                        selectFilterType == widget.optionOneName
                                            ? greenColor
                                            : blackColor),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 2.0,
                            color: selectFilterType == widget.optionOneName
                                ? greenColor
                                : greyColor,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectFilterType = widget.optionTwoName;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                widget.optionTwoName,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        selectFilterType == widget.optionTwoName
                                            ? greenColor
                                            : blackColor),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 2.0,
                            color: selectFilterType == widget.optionTwoName
                                ? greenColor
                                : greyColor,
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
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: selectFilterType == widget.optionOneName
                          ? filterFirstOption.length
                          : filterSecondOption.length,
                      itemBuilder: (context, index) => CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: greenColor,
                            value: selectFilterType == widget.optionOneName
                                ? filterFirstOption[index]["isChecked"]
                                : filterSecondOption[index]["isChecked"],
                            onChanged: (value) {
                              setState(() {
                                if (selectFilterType == widget.optionOneName) {
                                  filterFirstOption[index]["isChecked"] =
                                      value!;
                                } else {
                                  filterSecondOption[index]["isChecked"] =
                                      value!;
                                }
                              });
                            },
                            title: Text(
                              selectFilterType == widget.optionOneName
                                  ? filterFirstOption[index]["title"]
                                  : filterSecondOption[index]["title"],
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                color: selectFilterType == widget.optionOneName
                                    ? filterFirstOption[index]["isChecked"]
                                        ? greenColor
                                        : blackColor
                                    : filterSecondOption[index]["isChecked"]
                                        ? greenColor
                                        : blackColor,
                              ),
                            ),
                          )))),
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
                  Navigator.of(context).pop();
                  widget.filterFunction(filterFirstOption, filterSecondOption,
                      widget.filterName, "", "");
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
