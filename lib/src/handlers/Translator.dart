import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';
import '../dictionaries/dictionary.dart';
class Translator {

  String getPartTranslate(format, index) {
    switch (format) {
      case PartFormat.month:
        return EventCalendar.calendarProvider.getMonthName(index);
      default:
        return '';
    }
  }

  String getTranslation(String word) =>
      titles[EventCalendar.calendarLanguage][word];

  List<String> getShortNameOfDays() =>
      shortDayNames[EventCalendar.calendarLanguage][EventCalendar.calendarType];

  List<String> getFullNameOfDays() =>
      fullDayNames[EventCalendar.calendarLanguage][EventCalendar.calendarType];

  List<String> getFullMonthNames() =>
      fullMonthNames[EventCalendar.calendarLanguage][EventCalendar.calendarType];

  List<String> getShortMonthNames() =>
      shortMonthNames[EventCalendar.calendarLanguage][EventCalendar.calendarType];

  bool isRTL() => 
      directionIsRTL[EventCalendar.calendarLanguage];
}
