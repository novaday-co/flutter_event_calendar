import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/event_calendar.dart';
import 'package:flutter_event_calendar/src/models/style/headers_style.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';
import '../dictionaries/dictionary.dart';

class Translator {
  static String getPartTranslate(HeadersStyle options, format, index) {
    switch (format) {
      case PartFormat.month:
        return _getMonthName(options.monthStringType, index);
      default:
        return '';
    }
  }

  static String _getMonthName(MonthStringTypes type, index) {
    switch (type) {
      case MonthStringTypes.Short:
        return getShortMonthNames()[index];
      case MonthStringTypes.Full:
        return getFullMonthNames()[index];
    }
  }

  static String getTranslation(String word) =>
      titles[EventCalendar.calendarLanguage][word];

  static List<String> getNameOfDay(WeekDayStringTypes type) {
    switch (type) {
      case WeekDayStringTypes.Short:
        return getShortNameOfDays();
      case WeekDayStringTypes.Full:
        return getFullNameOfDays();
    }
  }


  static Map getMonthDaysShort(int monthIndex) =>
      EventCalendar.calendarProvider.getMonthDaysShort(monthIndex);

  static List<String> getShortNameOfDays() =>
      shortDayNames[EventCalendar.calendarLanguage][EventCalendar.calendarType];

  static List<String> getFullNameOfDays() =>
      fullDayNames[EventCalendar.calendarLanguage][EventCalendar.calendarType];

  static List<String> getFullMonthNames() =>
      fullMonthNames[EventCalendar.calendarLanguage]
          [EventCalendar.calendarType];

  static List<String> getShortMonthNames() =>
      shortMonthNames[EventCalendar.calendarLanguage]
          [EventCalendar.calendarType];

  static bool isRTL() => directionIsRTL[EventCalendar.calendarLanguage];
}
