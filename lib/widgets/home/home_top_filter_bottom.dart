import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/order_platform.dart';
import 'package:bakingup_frontend/enum/order_type.dart';
import 'package:bakingup_frontend/models/home.dart';
import 'package:bakingup_frontend/services/network_service.dart';
import 'package:bakingup_frontend/widgets/baking_up_filter_multiple_modal_bottom.dart';
import 'package:bakingup_frontend/widgets/home/home_modal_bottom.dart';
import 'package:bakingup_frontend/widgets/home/home_top_filter_bottom_one_option.dart';
import 'package:flutter/material.dart';

class HomeTopFilterBottom extends StatefulWidget {
  final Function filterFunction;
  const HomeTopFilterBottom({super.key, required this.filterFunction});

  @override
  State<HomeTopFilterBottom> createState() => _HomeTopFilterBottomState();
}

class _HomeTopFilterBottomState extends State<HomeTopFilterBottom> {
  var filterList = [
    "Best Selling",
    "Worst Selling",
    "Top Profit Ratio",
    "Top Profit Revenue",
    "Top Profit Margin",
    "Selling Quickly",
    "Wasted Ingredients",
    "Wasted Bakery Stock"
  ];

  List<Map<String, dynamic>> filterSaleChannelList = [
    {"title": "Store", "isChecked": true},
    {"title": "Line Man", "isChecked": false},
    {"title": "Grab", "isChecked": false},
    {"title": "Facebook", "isChecked": false},
    {"title": "Website", "isChecked": false},
    {"title": "Other", "isChecked": false},
  ];

  List<Map<String, dynamic>> filterOrderTypeList = [
    {"title": "Bulk Order", "isChecked": true},
    {"title": "Personal", "isChecked": false},
    {"title": "Special Day", "isChecked": false},
    {"title": "Festival", "isChecked": false},
    {"title": "Other", "isChecked": false},
  ];

  List<String> wastedIngredientsList = ["Solid", "Liquid"];

  List<String> sortBy = ["Ascending", "Descending"];
  String filterType = "";

  Future<void> _filter(List<Map<String, dynamic>> filterFirstOption,
      List<Map<String, dynamic>> filterSecondOption) async {
    print(filterFirstOption);
    List<String> orderPlatform = [];
    List<String> orderType = [];
    String userID = "1";
    for (var i = 0; i < filterFirstOption.length; i++) {
      if (filterFirstOption[i]["isChecked"]) {
        orderPlatform[i] =
            convertOrderPlatformString(filterFirstOption[i]["title"]);
      }
    }

    for (var i = 0; i < filterSecondOption.length; i++) {
      if (filterSecondOption[i]["isChecked"]) {
        orderType[i] = convertOrderTypeString(filterSecondOption[i]["title"]);
      }
    }
    try {
      final data = {
        "filter_type": filterType,
        "order_type": orderType,
        "order_platform": orderPlatform,
        "user_id": userID
      };
      final response = await NetworkService.instance
          .post("/api/home/getTopProduct", data: data);

      final topProductListResponse = TopProductResponse.fromJson(response);
      final dataResponse = topProductListResponse.data;
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: whiteColor,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
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
                ),
              ),
            ],
          ),
          Divider(
            color: greyColor,
            thickness: 2,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filterList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: ListTile(
                        dense: true,
                        title: Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            bottom: 5,
                          ),
                          child: Text(
                            filterList[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            filterType = filterList[index];
                          });
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
                            useRootNavigator: true,
                            builder: (BuildContext context) {
                              return filterList[index] == "Wasted Ingredients"
                                  ? HomeModalBottom(
                                      optionsOne: wastedIngredientsList,
                                      optionOneName: "Ingredient Type",
                                      defaultFilteringValue: "Solid",
                                      defaultSortingValue: "Ascending Order",
                                      filterFunction: widget.filterFunction,
                                      filterName: filterList[index],
                                    )
                                  : filterList[index] == "Wasted Bakery Stock"
                                      ? HomeTopFilterBottomOneOption(
                                          defaultSortingValue:
                                              "Ascending Order",
                                          filterFunction: _filter,
                                          filterName: "Wasted Bakery Stock",
                                        )
                                      : BakingUpFilterMultipleModalBottom(
                                          optionOneName: "By Sales Channel",
                                          optionTwoName: "By Order Type",
                                          optionsOne: filterSaleChannelList,
                                          optionsTwo: filterOrderTypeList,
                                          filterName: filterList[index],
                                          filterFunction: widget.filterFunction,
                                        );
                            },
                          );
                        },
                      ),
                    ),
                    Divider(
                      color: greyColor,
                      thickness: 2,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
