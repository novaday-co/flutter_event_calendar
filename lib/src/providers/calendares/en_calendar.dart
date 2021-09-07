import 'dart:ui';

import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/providers/calendares/calendar_provider.dart';
import 'package:flutter_event_calendar/src/utils/types/calendar_types.dart';
import 'package:shamsi_date/shamsi_date.dart';

class EnCalendar extends CalendarProvider {
  @override
  List<String> getShortNameOfDays() =>
      ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

  @override
  List<String> getFullNameOfDays() => [
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday'
      ];

  @override
  List<String> getFullMonthNames() => [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];

  @override
  List<String> getShortMonthNames() => [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];

  @override
  String getDateTime() {
    return DateTime.now().toString();
  }

  @override
  String getNextMonthDateTime() {
    final date = _getSelectedDate();
    return DateTime(date.year, date.month + 1, 1).toString();
  }

  @override
  String getPreviousMonthDateTime() {
    final date = _getSelectedDate();
    return DateTime(date.year, date.month - 1, 1).toString();
  }

  @override
  String getPreviousDayDateTime() {
    final date = _getSelectedDate();
    return DateTime(date.year, date.month, date.day - 1).toString();
  }

  @override
  String getNextDayDateTime() {
    final date = _getSelectedDate();
    return DateTime(date.year, date.month, date.day + 1).toString();
  }

  @override
  bool isRTL() => false;

  @override
  Map getMonthDays(int index) {
    Map days = {};
    DateTime now = _getSelectedDate();
    int monthLength = DateTime(now.year, index + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(now.year, index, 1);
    int dayIndex = firstDayOfMonth.weekday;

    switch (EventCalendar.headerWeekDayStringType) {
      case HeaderWeekDayStringTypes.Full:
        for (var i = 1; i <= monthLength; i++) {
          days[i] = getFullNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
      case HeaderWeekDayStringTypes.Short:
        for (var i = 1; i <= monthLength; i++) {
          days[i] = getShortNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
    }
    return days;
  }

  @override
  List<int> getYears() {
    int year = _getSelectedDate().year;
    List<int> years = [];
    for (var i = -100; i <= 50; i++) years.add(year + i);
    return years;
  }

  DateTime _getSelectedDate() {
    return DateTime.parse(EventCalendar.dateTime);
  }

  @override
  String goToDay(index) {
    dynamic date = _getSelectedDate();
    dynamic newDate = DateTime(date.year, date.month, index);
    return newDate.toString();
  }

  @override
  String goToMonth(index) {
    dynamic date = _getSelectedDate();
    dynamic newDate = DateTime(date.year, index, 1);
    return newDate.toString();
  }

  @override
  String goToYear(index) {
    dynamic date = _getSelectedDate();
    dynamic newDate = DateTime(index, date.month, 1);
    return newDate.toString();
  }

  @override
  int getDateTimePart(PartFormat format) {
    DateTime date = _getSelectedDate();
    switch (format) {
      case PartFormat.year:
        return date.year;
      case PartFormat.month:
        return date.month;
      case PartFormat.day:
        return date.day;
    }
  }

  @override
  String getMonthName(index) {
    switch (EventCalendar.headerMonthStringType) {
      case HeaderMonthStringTypes.Short:
        return getShortMonthNames()[index];
      case HeaderMonthStringTypes.Full:
        return getFullMonthNames()[index];
    }
  }
}
