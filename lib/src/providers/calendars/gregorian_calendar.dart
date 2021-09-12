import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/translator.dart';
import 'package:flutter_event_calendar/src/providers/calendars/calendar_provider.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';

class GregorianCalendar extends CalendarProvider {
  @override
  EventDateTime getDateTime() {
    return EventDateTime.parse(DateTime.now().toString());
  }

  @override
  EventDateTime getNextMonthDateTime() {
    final date = _getSelectedDate();
    return EventDateTime(year: date.year, month: date.month + 1, day: 1);
  }

  @override
  EventDateTime getPreviousMonthDateTime() {
    final date = _getSelectedDate();
    return EventDateTime(year: date.year, month: date.month - 1, day: 1);
  }

  @override
  EventDateTime getPreviousDayDateTime() {
    final date = _getSelectedDate();
    return EventDateTime(year: date.year, month: date.month, day: date.day - 1);
  }

  @override
  EventDateTime getNextDayDateTime() {
    final date = _getSelectedDate();
    return EventDateTime(year: date.year, month: date.month, day: date.day + 1);
  }

  @override
  bool isRTL() => Translator.isRTL();

  @override
  Map getMonthDays(int index) {
    Map days = {};
    EventDateTime now = _getSelectedDate();
    int monthLength = DateTime(now.year, index + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(now.year, index, 1);
    int dayIndex = firstDayOfMonth.weekday;

    switch (EventCalendar.headerWeekDayStringType) {
      case HeaderWeekDayStringTypes.Full:
        for (var i = 1; i <= monthLength; i++) {
          days[i] = Translator.getFullNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
      case HeaderWeekDayStringTypes.Short:
        for (var i = 1; i <= monthLength; i++) {
          days[i] = Translator.getShortNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
    }
    return days;
  }

  @override
  Map getMonthDaysShort(int index) {
    Map days = {};
    EventDateTime now = _getSelectedDate();
    int monthLength = DateTime(now.year, index + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(now.year, index, 1);
    int dayIndex = firstDayOfMonth.weekday;
    for (var i = 1; i <= monthLength; i++) {
      days[i] = Translator.getShortNameOfDays()[dayIndex % 7];
      dayIndex++;
    }
    return days;
  }

  @override
  List<String> getNameOfDays() {
    switch (EventCalendar.headerWeekDayStringType) {
      case HeaderWeekDayStringTypes.Full:
        return Translator.getFullNameOfDays();
      case HeaderWeekDayStringTypes.Short:
        return Translator.getShortNameOfDays();
    }
  }

  @override
  List<int> getYears() {
    int year = _getSelectedDate().year;
    List<int> years = [];
    for (var i = -100; i <= 50; i++) years.add(year + i);
    return years;
  }

  EventDateTime _getSelectedDate() {
    return EventCalendar.dateTime;
  }

  @override
  EventDateTime goToDay(index) {
    dynamic date = _getSelectedDate();
    return EventDateTime(year: date.year, month: date.month, day: index);
  }

  @override
  EventDateTime goToMonth(index) {
    dynamic date = _getSelectedDate();
    return EventDateTime(year: date.year, month: index, day: 1);
  }

  @override
  EventDateTime goToYear(index) {
    dynamic date = _getSelectedDate();
    return EventDateTime(year: index, month: date.month, day: 1);
  }

  @override
  int getDateTimePart(PartFormat format) {
    EventDateTime date = _getSelectedDate();
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
