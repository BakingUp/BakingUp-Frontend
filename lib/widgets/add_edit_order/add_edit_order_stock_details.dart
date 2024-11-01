import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/stock_order_page.dart';
import 'package:flutter/material.dart';

class AddEditOrderStockDetails extends StatefulWidget {
  final List<StockOrderItemData> stocks;
  final int index;
  final bool isPreOrder;
  final List<StockOrderItemData> selectedStockList;
  
  const AddEditOrderStockDetails(
      {super.key, required this.stocks, required this.index, required this.isPreOrder, required this.selectedStockList});

  @override
  State<AddEditOrderStockDetails> createState() =>
      _AddEditOrderStockDetailsState();
}

class _AddEditOrderStockDetailsState extends State<AddEditOrderStockDetails> {
  int _currentQuantity = 0;
  int divisions = 1;

  void _updateSelectedStockQuantity(int newQuantity){
    setState(() {
      _currentQuantity = newQuantity;
      widget.selectedStockList[widget.index] = widget.selectedStockList[widget.index].copyWith(quantity: _currentQuantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
        decoration: BoxDecoration(
          color: widget.isPreOrder? pinkColor: beigeColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.network(
                      widget.stocks[widget.index].recipeUrl,
                      width: 90,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.stocks[widget.index].recipeName,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Quantity: ${widget.stocks[widget.index].quantity}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'EXP: ${widget.stocks[widget.index].sellByDate}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: whiteColor,
                  radius: 10,
                  child: IconButton(
                    onPressed: () {
                      if (_currentQuantity > 0) {
                        _updateSelectedStockQuantity(_currentQuantity - divisions);
                      }
                    },
                    icon: Icon(
                      Icons.remove,
                      size: 14,
                      color: blackColor,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  _currentQuantity.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 15),
                CircleAvatar(
                  backgroundColor: whiteColor,
                  radius: 10,
                  child: IconButton(
                    onPressed: () {
                      if (widget.isPreOrder || _currentQuantity + 1 <= widget.stocks[widget.index].quantity) {
                        _updateSelectedStockQuantity(_currentQuantity + divisions);
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      size: 14,
                      color: blackColor,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
