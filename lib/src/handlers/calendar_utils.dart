import 'package:collection/collection.dart';

import '../../flutter_event_calendar.dart';
import 'translator.dart';

class CalendarUtils {
  static goToYear(index) {
    EventCalendar.dateTime = EventCalendar.calendarProvider.goToYear(index);
  }

  static goToMonth(index) {
    EventCalendar.dateTime = EventCalendar.calendarProvider.goToMonth(index);
  }

  static goToDay(index) {
    EventCalendar.dateTime = EventCalendar.calendarProvider.goToDay(index);
  }

  static nextDay() {
    EventCalendar.dateTime =
        EventCalendar.calendarProvider.getNextDayDateTime();
  }

  static previousDay() {
    EventCalendar.dateTime =
        EventCalendar.calendarProvider.getPreviousDayDateTime();
  }

  static nextMonth() {
    EventCalendar.dateTime =
        EventCalendar.calendarProvider.getNextMonthDateTime();
  }

  static previousMonth() {
    EventCalendar.dateTime =
        EventCalendar.calendarProvider.getPreviousMonthDateTime();
  }

  static List getYears() => EventCalendar.calendarProvider.getYears();
  static List getDaysAmount() => EventCalendar.calendarProvider.getDayAmount();

  static Map getDays(WeekDayStringTypes type, int monthIndex) {
     return EventCalendar.calendarProvider.getMonthDays(type, monthIndex);


  }

  static Map getMonthDays(WeekDayStringTypes type, int monthIndex) =>
      EventCalendar.calendarProvider.getMonthDays(type, monthIndex);

  static getPartByString(
      {required PartFormat format, required HeaderOptions options}) {
    return Translator.getPartTranslate(options, format,
        EventCalendar.calendarProvider.getDateTimePart(format) - 1);
  }

  static getPartByInt({required PartFormat format}) {
    return EventCalendar.calendarProvider.getDateTimePart(format);
  }

  static CalendarDateTime? getFromSpecialDay(
      List<CalendarDateTime> specialDays, int year, int month, int day) {
    return specialDays.firstWhereOrNull((element) => _isRange(element)
        ? isInRange(element, year, month, day)
        : element.isDateEqualByInt(year, month, day));
  }

  static _isRange(CalendarDateTime element) =>
      element.toMonth != null || element.toDay != null;

  static isEndOfRange(CalendarDateTime? element, int year, int month, int day) {
    if (element?.year != year) return false;
    if (element?.toMonth == null) {
      if (element?.toDay == null) return element?.day == day;
      return element?.toDay == day;
    } else if (element?.toMonth == month) {
      if (element?.toDay == null) return element?.day == day;
      return element?.toDay == day;
    }
    return false;
  }

  static isStartOfRange(
          CalendarDateTime? element, int year, int month, int day) =>
      element?.year == year && element?.month == month && element?.day == day;

  static isInRange(
      CalendarDateTime? selectedDatetime, int year, int month, int day) {
    if (selectedDatetime?.year != year) return false;
    if (selectedDatetime?.month != null && selectedDatetime!.month > month)
      return false;
    if (selectedDatetime?.toMonth != null && selectedDatetime!.toMonth! < month)
      return false;
    if (selectedDatetime?.day != null &&
        selectedDatetime!.month == month &&
        selectedDatetime.day > day) return false;

    if (selectedDatetime?.toMonth != null) {
      if (selectedDatetime!.toDay != null &&
          selectedDatetime.toMonth == month &&
          selectedDatetime.toDay! < day) return false;
    } else {
      if (selectedDatetime!.toDay != null &&
          (selectedDatetime.month != month || selectedDatetime.toDay! < day))
        return false;
    }
    return true;
  }

  static isBeforeThanToday(int currentYear, int currentMonth, int currentDay) {
    CalendarDateTime now = EventCalendar.calendarProvider.getDateTime();
    DateTime currentDateTime = DateTime(currentYear, currentMonth, currentDay);
    return currentDateTime.difference(now.toDateTime()).isNegative;
  }

  static CalendarType getCalendarType() {
    return EventCalendar.calendarProvider.getCalendarType();
  }
}
