import 'dart:ui';

import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/Translator.dart';
import 'package:flutter_event_calendar/src/providers/calendares/calendar_provider.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';
import 'package:shamsi_date/shamsi_date.dart';

class JalaliCalendar extends CalendarProvider {

  @override
  String getDateTime() {
    final f = Jalali.now().formatter;
    return '${f.y}-${f.mm}-${f.dd}';
  }

  @override
  String getNextMonthDateTime() {
    final date = _getSelectedDate();
    final newDate = date.addMonths(1);
    final f = newDate.formatter;
    return '${f.y}-${f.mm}-01';
  }

  @override
  String getPreviousMonthDateTime() {
    final date = _getSelectedDate();
    dynamic newDate = date.addMonths(-1);
    final f = newDate.formatter;
    return '${f.y}-${f.mm}-01';
  }

  @override
  String getPreviousDayDateTime() {
    dynamic date = _getSelectedDate();
    dynamic newDate = date.addDays(-1);
    final f = newDate.formatter;
    return '${f.y}-${f.mm}-${f.dd}';
  }

  @override
  String getNextDayDateTime() {
    dynamic date = _getSelectedDate();
    dynamic newDate = date.addDays(1);
    final f = newDate.formatter;
    return '${f.y}-${f.mm}-${f.dd}';
  }

  @override
  bool isRTL() => Translator().isRTL();

  @override
  Map getMonthDays(int index) {
    Map days = {};
    Jalali firstDayOfMonth = _getSelectedDate().withMonth(index).withDay(1);
    int dayIndex = firstDayOfMonth.weekDay - 1;
    switch (EventCalendar.headerWeekDayStringType) {
      case HeaderWeekDayStringTypes.Full:
        for (var i = 1; i <= firstDayOfMonth.monthLength; i++) {
          days[i] = Translator().getFullNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
      case HeaderWeekDayStringTypes.Short:
        for (var i = 1; i <= firstDayOfMonth.monthLength; i++) {
          days[i] = Translator().getShortNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
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

  Jalali _getSelectedDate() {
    List dateTimeParts = EventCalendar.dateTime.split(' ');
    List dateParts = dateTimeParts[0].split('-');
    Jalali jv = Jalali(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
    );
    return jv;
  }

  @override
  String goToDay(index) {
    dynamic date = _getSelectedDate();
    index = index < 10 ? '0$index' : index;
    final f = date.formatter;
    return '${f.y}-${f.mm}-$index';
  }

  @override
  String goToMonth(index) {
    dynamic date = _getSelectedDate();
    final f = date.formatter;
    return '${f.y}-$index-01';
  }

  @override
  String goToYear(index) {
    dynamic date = _getSelectedDate();
    final f = date.formatter;
    return '$index-${f.mm}-01';
  }

  @override
  int getDateTimePart(PartFormat format) {
    Jalali date = _getSelectedDate();
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

  @override
  Map getMonthDaysShort(int index) {
    Map days = {};
    Jalali firstDayOfMonth = _getSelectedDate().withMonth(index).withDay(1);
    int dayIndex = firstDayOfMonth.weekDay - 1;
    for (var i = 1; i <= firstDayOfMonth.monthLength; i++) {
      days[i] = Translator().getShortNameOfDays()[dayIndex % 7];
      dayIndex++;
    }
    return days;
  }

}
