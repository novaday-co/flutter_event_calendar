import 'package:flutter_event_calendar/src/dictionaries/days.dart';
import 'package:flutter_event_calendar/src/dictionaries/months.dart';
import 'package:flutter_event_calendar/src/dictionaries/locales.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/utils/types/calendar_types.dart';

class Translator {
  List getMonthNames() {
    return EventCalendar.calendarProvider.getFullMonthNames();
  }

  String getPartTranslate(format, index) {
    switch (format) {
      case 'month':
        return EventCalendar.calendarProvider.getMonthName(index);
      default:
        return '';
    }
  }

  // String getWeekDayNameWithIndex(index) {
  //   switch (EventCalendar.headerWeekDayStringType) {
  //     case HeaderWeekDayStringTypes.Full:
  //       return fullDayNames[EventCalendar.type][index];
  //     case HeaderWeekDayStringTypes.Short:
  //       return shortDayNames[EventCalendar.type][index];
  //   }
  // }
  //
  // String getMonthNameWithIndex(index) {
  //   switch (EventCalendar.headerMonthStringType) {
  //     case HeaderMonthStringTypes.Full:
  //       return fullMonthNames[EventCalendar.type][index];
  //     case HeaderMonthStringTypes.Short:
  //       return shortMonthNames[EventCalendar.type][index];
  //   }
  // }

  String trans(word) {
    switch (EventCalendar.locale) {
      case 'fa':
        return fa[word];
      case 'en':
        return en[word];
    }
    return '';
  }
}
