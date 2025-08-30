// lib/utils/calendar_utils.dart
import 'package:flutter/cupertino.dart';
import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';

/// Reusable calendar opener. Call this from the *button's* BuildContext.
Future<DateTime?> showCalendarPicker({
  required BuildContext context,                 // pass the *button* context
  DateTime? initialDateTime,
  DateTime? minimumDateTime,
  DateTime? maximumDateTime,
  CupertinoCalendarMode mode = CupertinoCalendarMode.date, // or .dateTime
  String? timeLabel,
  ValueChanged<DateTime>? onDateTimeChanged,
  bool Function(DateTime)? selectableDayPredicate,
}) {
  final renderBox = context.findRenderObject() as RenderBox?;

  final now = DateTime.now();

  // light responsiveness for spacing/offset so it feels right on bigger screens
  final w = MediaQuery.of(context).size.width;
  final isTablet = w >= 600 && w < 1200;
  final isDesktop = w >= 1200;

  final horizontalSpacing = isDesktop ? 24.0 : (isTablet ? 18.0 : 12.0);
  final verticalSpacing   = isDesktop ? 24.0 : (isTablet ? 18.0 : 12.0);
  final offset            = isDesktop ? const Offset(0, 16)
      : (isTablet ? const Offset(0, 12) : const Offset(0, 8));

  return showCupertinoCalendarPicker(
    context,
    widgetRenderBox: renderBox,
    minimumDateTime: minimumDateTime ?? now.subtract(const Duration(days: 365)),
    initialDateTime: initialDateTime ?? now,
    maximumDateTime: maximumDateTime ?? now.add(const Duration(days: 365)),
    mode: mode,
    timeLabel: timeLabel,
    onDateTimeChanged: onDateTimeChanged,
    selectableDayPredicate: selectableDayPredicate,
    horizontalSpacing: horizontalSpacing,
    verticalSpacing: verticalSpacing,
    offset: offset,
  );
}
