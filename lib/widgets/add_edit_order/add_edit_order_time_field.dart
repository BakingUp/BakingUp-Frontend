import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class AddEditOrderTimeField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;

  const AddEditOrderTimeField(
      {super.key, required this.controller, this.label});

  @override
  State<AddEditOrderTimeField> createState() => _AddEditOrderTimeFieldState();
}

class _AddEditOrderTimeFieldState extends State<AddEditOrderTimeField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        height: 45,
        child: TextField(
            controller: widget.controller,
            readOnly: true,
            onTap: () => showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((TimeOfDay? time) {
                  if (time != null) {
                    widget.controller.text = time.format(context);
                  }
                }),
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300,
            ),
            cursorColor: blackColor,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: darkGreyColor, width: 0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: darkGreyColor, width: 0.5),
              ),
              labelText: widget.label,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.timer, color: darkGreyColor),
                onPressed: () => showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((TimeOfDay? time) {
                  if (time != null) {
                    widget.controller.text = time.format(context);
                  }
                }),
              ),
            )));
  }
}
