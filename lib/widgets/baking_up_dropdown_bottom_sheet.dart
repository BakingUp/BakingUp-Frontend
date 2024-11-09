import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';

class BakingUpDropdownBottomSheet extends StatefulWidget {
  final List<String> options;
  final String topic;
  final String selectedOption;
  final Function(String) onApply;
  final Function(int)? onApplyIndex;
  const BakingUpDropdownBottomSheet({
    super.key,
    required this.options,
    required this.topic,
    required this.selectedOption,
    required this.onApply,
    this.onApplyIndex,
  });

  @override
  State<BakingUpDropdownBottomSheet> createState() =>
      _BakingUpDropdownBottomSheetState();
}

class _BakingUpDropdownBottomSheetState
    extends State<BakingUpDropdownBottomSheet> {
  String? selectedOption = "";
  int selectedIndex = 0;

  @override
  void initState() {
    selectedOption = widget.selectedOption.isNotEmpty
        ? widget.selectedOption
        : widget.options.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
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
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          widget.topic,
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                          ),
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
                        )),
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
              child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: widget.options.map((name) {
                      bool isSelected;
                      if (selectedOption == name) {
                        isSelected = true;
                      } else {
                        isSelected = false;
                      }
                      return Material(
                          color: Colors.transparent,
                          child: RadioListTile<String>(
                            title: Text(
                              name,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                color: isSelected ? greenColor : blackColor,
                              ),
                            ),
                            value: name,
                            groupValue: selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                selectedOption = value;
                                selectedIndex = widget.options.indexOf(value!);
                              });
                            },
                            activeColor: greenColor,
                          ));
                    }).toList(),
                  ))),
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
                  widget.onApply(selectedOption!);
                  if (widget.onApplyIndex != null) {
                    widget.onApplyIndex!(selectedIndex);
                  }
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
