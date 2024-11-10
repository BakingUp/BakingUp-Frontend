import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/models/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductionDetail extends StatelessWidget {
  final List<ProductionQueue> productionQueue;
  final int index;

  const ProductionDetail(
      {super.key, required this.productionQueue, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
      decoration: BoxDecoration(
        color: pinkColor,
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
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.network(
                  '${dotenv.env['API_BASE_URL']}/${productionQueue[index].imgUrl}',
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
              const Padding(padding: EdgeInsets.only(right: 16.0)),
            ],
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productionQueue[index].name,
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'Order# ${productionQueue[index].orderIndex}',
                      style: TextStyle(
                        color: blackColor,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Quantity: ${productionQueue[index].quantity}',
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'Pick-Up Date: ${productionQueue[index].pickUpDate}',
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 20.0))
        ],
      ),
    );
  }
}
