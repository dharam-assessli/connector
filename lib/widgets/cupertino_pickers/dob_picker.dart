import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class DOBPicker extends StatelessWidget {
  const DOBPicker({
    required this.initialDateTime,
    required this.onDateTimeChanged,
    super.key,
  });
  final DateTime? initialDateTime;
  final void Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    return CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: TextStyle(
            fontSize: 16,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
      child: CupertinoDatePicker(
        key: const Key("dob"),
        itemExtent: 40,
        mode: CupertinoDatePickerMode.date,
        dateOrder: DatePickerDateOrder.dmy,
        minimumDate: DateTime(1900),
        maximumDate: now,
        initialDateTime: initialDateTime ?? now,
        changeReportingBehavior: ChangeReportingBehavior.onScrollEnd,
        onDateTimeChanged: onDateTimeChanged,
      ),
    );
  }
}
