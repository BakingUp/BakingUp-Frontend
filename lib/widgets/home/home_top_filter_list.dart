import 'package:bakingup_frontend/models/home.dart';
import 'package:bakingup_frontend/widgets/home/home_top_filter_item.dart';
import 'package:bakingup_frontend/widgets/home/home_top_filter_item_loading.dart';
import 'package:flutter/material.dart';

class HomeTopFilterList extends StatelessWidget {
  final bool isLoading;
  final List<TopProductItem> topProductList;
  const HomeTopFilterList(
      {super.key, required this.isLoading, required this.topProductList});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Expanded(
            child: Container(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const HomeTopFilterItemLoading();
                }),
          ))
        : Expanded(
            child: Container(
            child: ListView.builder(
                itemCount: topProductList.length,
                itemBuilder: (context, index) {
                  return HomeTopFilterItem(
                      topProductList: topProductList,
                      index: index,
                      isLoading: isLoading);
                }),
          ));
  }
}
