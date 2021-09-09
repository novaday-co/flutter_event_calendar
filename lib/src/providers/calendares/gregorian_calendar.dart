import 'dart:ui';

import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/Translator.dart';
import 'package:flutter_event_calendar/src/providers/calendares/calendar_provider.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';

class GregorianCalendar extends CalendarProvider {

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
  bool isRTL() => Translator().isRTL();

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
          days[i] = Translator().getFullNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
      case HeaderWeekDayStringTypes.Short:
        for (var i = 1; i <= monthLength; i++) {
          days[i] = Translator().getShortNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
    }
    return days;
  }

  @override
  Map getMonthDaysShort(int index) {
    Map days = {};
    DateTime now = _getSelectedDate();
    int monthLength = DateTime(now.year, index + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(now.year, index, 1);
    int dayIndex = firstDayOfMonth.weekday;
    for (var i = 1; i <= monthLength; i++) {
      days[i] = Translator().getShortNameOfDays()[dayIndex % 7];
      dayIndex++;
    }
    return days;
  }

  @override
  List<String> getNameOfDays() {
    switch (EventCalendar.headerWeekDayStringType) {
      case HeaderWeekDayStringTypes.Full:
        return Translator().getFullNameOfDays();
      case HeaderWeekDayStringTypes.Short:
        return Translator().getShortNameOfDays();
    }
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
        return Translator().getShortMonthNames()[index];
      case HeaderMonthStringTypes.Full:
        return Translator().getFullMonthNames()[index];
    }
  }

}
