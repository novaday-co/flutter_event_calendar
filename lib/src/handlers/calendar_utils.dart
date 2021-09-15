import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/event_calendar.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';
import 'translator.dart';
import 'package:collection/collection.dart';

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

  static Map getDays(HeaderWeekDayStringTypes type, int monthIndex) =>
      EventCalendar.calendarProvider.getMonthDays(type, monthIndex);

  static Map getMonthDaysShort(int monthIndex) =>
      EventCalendar.calendarProvider.getMonthDaysShort(monthIndex);

  static getPartByString(
      {required PartFormat format, required CalendarOptions options}) {
    return Translator.getPartTranslate(options, format,
        EventCalendar.calendarProvider.getDateTimePart(format) - 1);
  }

  static getPartByInt({required PartFormat format}) {
    return EventCalendar.calendarProvider.getDateTimePart(format);
  }

  static EventDateTime? getColorizedDay(
      List<EventDateTime> colorizedDays, int year, int month, int day) {
    final result = colorizedDays.firstWhereOrNull(
        (element) => element.isDateEqualByInt(year, month, day));

    return result;
  }

  static bool isDisabledDay(
      List<EventDateTime> disabledDays, year, month, day) {
    return disabledDays.firstWhereOrNull(
            (element) => element.isDateEqualByInt(year, month, day)) !=
        null;
  }

  static bool isEnabledDay(List<EventDateTime> enabledDays, year, month, day) {
    if (enabledDays.isEmpty) return true;
    return enabledDays.firstWhereOrNull(
            (element) => element.isDateEqualByInt(year, month, day)) !=
        null;
  }
}
