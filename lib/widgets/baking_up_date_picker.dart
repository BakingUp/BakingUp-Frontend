import 'package:bakingup_frontend/constants/colors.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class BakingUpDatePicker extends StatelessWidget {
  final List<DateTime> dates;
  final ValueChanged<List<DateTime>> onDateApply;
  const BakingUpDatePicker({
    super.key,
    required this.dates,
    required this.onDateApply,
  });

  @override
  Widget build(BuildContext context) {
    List<DateTime> selectedDates = [];

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: whiteColor),
            child: Column(
              children: [
                Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Select a date",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: greyColor,
                  thickness: 2,
                ),
              ],
            ),
          ),
          Expanded(
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                weekdayLabels: const [
                  'Sun',
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat',
                ],
                calendarViewMode: CalendarDatePicker2Mode.scroll,
                weekdayLabelTextStyle: TextStyle(
                  color: darkGreyColor,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
                dayTextStyle: TextStyle(
                  color: darkGreyColor,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
                yearTextStyle: TextStyle(
                  color: darkGreyColor,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
                controlsTextStyle: TextStyle(
                  color: blackColor,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
                selectedDayTextStyle: TextStyle(
                  color: greenColor,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
                centerAlignModePicker: true,
                hideScrollViewMonthWeekHeader: true,
                hideScrollViewTopHeaderDivider: true,
                selectedDayHighlightColor: lightGreenColor,
                daySplashColor: greyColor,
              ),
              value: dates,
              onValueChanged: (value) {
                selectedDates = value;
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightGreenColor,
                  minimumSize: const Size(200, 40),
                ),
                onPressed: () {
                  onDateApply(selectedDates);
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
