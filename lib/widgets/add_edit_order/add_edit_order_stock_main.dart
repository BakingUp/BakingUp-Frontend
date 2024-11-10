import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/stock_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddEditOrderStockMain extends StatefulWidget {
  final List<StockOrderItemData> stocks;
  final int index;
  final bool isPreOrder;

  const AddEditOrderStockMain(
      {super.key,
      required this.stocks,
      required this.index,
      required this.isPreOrder});

  @override
  State<AddEditOrderStockMain> createState() => _AddEditOrderStockMainState();
}

class _AddEditOrderStockMainState extends State<AddEditOrderStockMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
        decoration: BoxDecoration(
          color: widget.isPreOrder ? pinkColor : beigeColor,
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
                      '${dotenv.env['API_BASE_URL']}/${widget.stocks[widget.index].recipeUrl}',
                      width: 90,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/icons/no-image.jpg',
                          width: 90,
                          height: 60,
                          fit: BoxFit.cover,
                        );
                      },
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
                          '${widget.stocks[widget.index].sellingPrice} ฿',
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
                const SizedBox(width: 15),
                Text(
                  widget.stocks[widget.index].quantity.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 15),
              ],
            )
          ],
        ),
      ),
    );
  }
}
