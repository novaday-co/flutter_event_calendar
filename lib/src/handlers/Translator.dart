import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';

class Translator {

  List getMonthNames() {
    return EventCalendar.calendarProvider.getFullMonthNames();
  }

  List<String> getShortDayNames() {
    return EventCalendar.calendarProvider.getShortNameOfDays();
  }

  String getPartTranslate(format, index) {
    switch (format) {
      case PartFormat.month:
        return EventCalendar.calendarProvider.getMonthName(index);
      default:
        return '';
    }
  }

  String trans(word) {
    return EventCalendar.calendarProvider.getTranslation(word);
  }
}
