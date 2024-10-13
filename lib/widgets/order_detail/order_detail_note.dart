import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class OrderDetailNote extends StatelessWidget {
  final bool isLoading;
  final String? orderNoteText;
  final String? orderNoteCreateAt;

  const OrderDetailNote({
    super.key,
    required this.isLoading,
    required this.orderNoteText,
    required this.orderNoteCreateAt,
  });

  @override
  Widget build(BuildContext context) {
    if (orderNoteText == null ||
        orderNoteText!.isEmpty ||
        orderNoteText == '-') {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Note:',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: beigeColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      orderNoteText!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    orderNoteCreateAt ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
