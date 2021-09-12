import 'package:flutter_event_calendar/src/handlers/event_calendar.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';
import '../dictionaries/dictionary.dart';

class Translator {
  static String getPartTranslate(format, index) {
    switch (format) {
      case PartFormat.month:
        return EventCalendar.calendarProvider.getMonthName(index);
      default:
        return '';
    }
  }

  static String getTranslation(String word) =>
      titles[EventCalendar.calendarLanguage][word];

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
