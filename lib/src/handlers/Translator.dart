import 'package:flutter_event_calendar/src/dictionaries/days.dart';
import 'package:flutter_event_calendar/src/dictionaries/months.dart';
import 'package:flutter_event_calendar/src/dictionaries/locales.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';

class Translator {
  List getMonthNames() {
    return fullMonthNames[EventCalendar.type];
  }

  String getPartTranslate(format, index) {
    switch (format) {
      case 'month':
        return getMonthNameWithIndex(index);
      default:
        return '';
    }
  }

  String getWeekDayNameWithIndex(index) {
    switch (EventCalendar.headerWeekDayStringType) {
      case 'full':
        return fullDayNames[EventCalendar.type][index];
      case 'short':
        return shortDayNames[EventCalendar.type][index];
    }
    return '';
  }

  String getMonthNameWithIndex(index) {
    switch (EventCalendar.headerMonthStringType) {
      case 'full':
        return fullMonthNames[EventCalendar.type][index];

      case 'short':
        return shortMonthNames[EventCalendar.type][index];
    }
    return '';
  }

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
