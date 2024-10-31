import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingExpiredColorIconItem extends StatefulWidget {
  final Color color;
  final TextEditingController days;
  final bool? isGreen;
  const SettingExpiredColorIconItem({
    super.key,
    required this.color,
    required this.days,
    this.isGreen,
  });

  @override
  State<SettingExpiredColorIconItem> createState() =>
      _SettingExpiredColorIconItemState();
}

class _SettingExpiredColorIconItemState
    extends State<SettingExpiredColorIconItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: widget.color),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            child: widget.isGreen == true
                ? Text(
                    '> ${widget.days.text}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : TextFormField(
                    controller: widget.days,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                    ),
                    validator: (value) {
                      if (value == "") {
                        return 'Required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter
                          .digitsOnly, // Only allow digits
                    ],
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: darkGreyColor, width: 0.5)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: darkGreyColor, width: 0.5)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: blackColor),
                    ))),
        const SizedBox(
          width: 15,
        ),
        const Text(
          'days before expiration',
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
