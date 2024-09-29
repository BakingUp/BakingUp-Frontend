import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/baking_up_date_picker.dart';
import 'package:flutter/material.dart';

class AddEditStockInformationSellByDateField extends StatefulWidget {
  const AddEditStockInformationSellByDateField({super.key});

  @override
  AddEditStockInformationSellByDateFieldState createState() =>
      AddEditStockInformationSellByDateFieldState();
}

class AddEditStockInformationSellByDateFieldState
    extends State<AddEditStockInformationSellByDateField> {
  final TextEditingController _controller = TextEditingController();
  List<DateTime> dates = [
    DateTime.now(),
  ];

  void showDatePickerBottomSheet(BuildContext context, Color backgroundColor) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      builder: (BuildContext builder) {
        return BakingUpDatePicker(
          dates: dates,
          onDateApply: (List<DateTime> newDates) {
            setState(() {
              dates = newDates;
            });
            _controller.text =
                "${newDates[0].day}/${newDates[0].month}/${newDates[0].year}";
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 45,
      child: TextField(
        controller: _controller,
        readOnly: true,
        onTap: () => showDatePickerBottomSheet(context, backgroundColor),
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
          labelText: 'Sell-By Date',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today, color: darkGreyColor),
            onPressed: () =>
                showDatePickerBottomSheet(context, backgroundColor),
          ),
        ),
      ),
    );
  }
}
