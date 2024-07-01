// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_posresto_app/core/core/core.dart';

import '../core/constants/colors.dart';

class CustomDatePicker extends StatefulWidget {
  final void Function(DateTime selectedDate)? onDateSelected;
  final DateTime initialDate;
  final Widget? prefix;

  const CustomDatePicker({
    super.key,
    required this.initialDate,
    this.onDateSelected,
    this.prefix,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime selectedDate;

  @override
  void initState() {
    selectedDate = widget.initialDate;
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 500,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      style: const TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      readOnly: true,
                      controller: TextEditingController(
                        text: selectedDate.toFormattedDate2(),
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: const Badge(
                            label: Text(
                              "4",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            child: Icon(Icons.calendar_month),
                          ),
                        ),
                        prefix: widget.prefix,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(color: AppColors.stroke),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(color: AppColors.stroke),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
