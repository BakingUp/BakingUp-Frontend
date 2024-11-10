import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/enum/noti_item_type.dart';
import 'package:bakingup_frontend/enum/noti_type.dart';
import 'package:bakingup_frontend/models/notification.dart';
import 'package:bakingup_frontend/screens/ingredient_detail_screen.dart';
import 'package:bakingup_frontend/screens/preorder_order_detail_screen.dart';
import 'package:bakingup_frontend/screens/stock_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsMessageBox extends StatelessWidget {
  final NotificationItem noti;
  final Future<void> Function(String) readFunction;
  final Future<void> Function() fetchAllNotis;
  const NotificationsMessageBox(
      {super.key,
      required this.noti,
      required this.readFunction,
      required this.fetchAllNotis});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(noti.createdAt).toLocal();

    String dateTimeString = DateFormat('h:mm').format(dateTime);
    String period = DateFormat('a').format(dateTime);

    List<TextSpan> highlightText(String text) {
      final matches = RegExp(RegExp.escape(noti.itemName), caseSensitive: false)
          .allMatches(text);
      int currentIndex = 0;
      List<TextSpan> spans = [];

      for (final match in matches) {
        // Add normal text before the match
        if (match.start > currentIndex) {
          spans.add(TextSpan(
            text: text.substring(currentIndex, match.start),
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ));
        }
        // Add the matched phrase in red
        spans.add(TextSpan(
          text: text.substring(match.start, match.end),
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            color: noti.notiType == NotiType.info
                ? blueColor
                : noti.notiType == NotiType.warning
                    ? yellowColor
                    : redColor,
          ),
        ));
        currentIndex = match.end;
      }
      // Add any remaining text after the last match
      if (currentIndex < text.length) {
        spans.add(TextSpan(
          text: text.substring(currentIndex),
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ));
      }
      return spans;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 65,
              height: 65,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: beigeColor),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dateTimeString,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      period,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ])),
          GestureDetector(
            onTap: () {
              readFunction(noti.notiID);
              if (noti.notiItemType == NotiItemType.ingredient) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IngredientDetailScreen(
                              ingredientId: noti.itemID,
                            ))).then((value) {
                  fetchAllNotis();
                });
              } else if (noti.notiItemType == NotiItemType.stock) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StockDetailScreen(
                              recipeId: noti.itemID,
                            ))).then((value) {
                  fetchAllNotis();
                });
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PreorderOrderDetailScreen(
                              orderId: noti.itemID,
                            ))).then((value) {
                  fetchAllNotis();
                });
              }
            },
            child: Container(
              width: 250,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(13),
                  color: noti.isRead ? backgroundColor : pinkColor),
              constraints: const BoxConstraints(
                minHeight: 1,
                maxHeight: 150,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    noti.title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      children: highlightText(noti.message),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
