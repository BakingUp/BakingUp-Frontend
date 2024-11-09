import 'package:bakingup_frontend/constants/colors.dart';
import 'package:bakingup_frontend/widgets/baking_up_date_picker.dart';
import 'package:flutter/material.dart';

class AddEditStockInformationSellByDateField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onChanged;
  const AddEditStockInformationSellByDateField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  AddEditStockInformationSellByDateFieldState createState() =>
      AddEditStockInformationSellByDateFieldState();
}

class AddEditStockInformationSellByDateFieldState
    extends State<AddEditStockInformationSellByDateField> {
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

            int day = newDates[0].day;
            int month = newDates[0].month;
            int year = newDates[0].year;

            String formattedDay = day < 10 ? '0$day' : '$day';
            String formattedMonth = month < 10 ? '0$month' : '$month';

            widget.controller.text = "$formattedDay/$formattedMonth/$year";
            widget.onChanged();
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
        focusNode: widget.focusNode,
        controller: widget.controller,
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
