import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingFixCostItem extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final Function errorFunction;
  final Function errorNoFunction;
  const SettingFixCostItem(
      {super.key,
      required this.title,
      required this.controller,
      required this.errorFunction,
      required this.errorNoFunction});

  @override
  State<SettingFixCostItem> createState() => _SettingFixCostItemState();
}

class _SettingFixCostItemState extends State<SettingFixCostItem> {
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  height: 40,
                  child: TextFormField(
                      controller: widget.controller,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
                      ),
                      validator: (value) {
                        final v = double.parse(value!);
                        if (v > 999999) {
                          setState(() {
                            errorMessage = '<= 999,999';
                            widget.errorFunction();
                          });
                        } else {
                          setState(() {
                            errorMessage = '';
                            widget.errorNoFunction();
                          });
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                          labelText: widget.title,
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 11, horizontal: 10))),
                ),
                if (errorMessage.isNotEmpty) // Display error message if any
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: redColor,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            const Text("฿")
          ],
        )
      ],
    );
  }
}
