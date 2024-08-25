import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class AddEditStockInformationCookingTimeField extends StatefulWidget {
  const AddEditStockInformationCookingTimeField({super.key});

  @override
  AddEditStockInformationCookingTimeFieldState createState() =>
      AddEditStockInformationCookingTimeFieldState();
}

class AddEditStockInformationCookingTimeFieldState
    extends State<AddEditStockInformationCookingTimeField> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _controller.text = "${picked.hour}:${picked.minute}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 45,
      child: TextField(
        controller: _controller,
        readOnly: true,
        onTap: () => _selectTime(context),
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
          labelText: 'Cooking Time',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.access_time, color: darkGreyColor),
            onPressed: () => _selectTime(context),
          ),
        ),
      ),
    );
  }
}
