import 'package:bakingup_frontend/models/user_info.dart';
import 'package:bakingup_frontend/widgets/profile/production_detail.dart';
import 'package:flutter/material.dart';

class ProductionQueueList extends StatefulWidget {
  final List<ProductionQueue> productionQueue;
  final bool isLoading;

  const ProductionQueueList(
      {super.key, required this.productionQueue, required this.isLoading});

  @override
  State<ProductionQueueList> createState() => _ProductionQueueListState();
}

class _ProductionQueueListState extends State<ProductionQueueList> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemCount: 1,
              itemBuilder: (context, index) {
                // return "Loading";
              },
            ),
          )
        : SizedBox(
            height: 250,
            child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemCount: widget.productionQueue.length,
                itemBuilder: (context, index) {
                  return ProductionDetail(
                      productionQueue: widget.productionQueue, index: index);
                }),
          );
  }
}
