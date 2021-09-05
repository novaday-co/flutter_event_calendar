import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/utils/types/calendar_types.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'Translator.dart';

class CalendarSelector {
  goToYear(index) {
    EventCalendar.dateTime = EventCalendar.calendarProvider.goToYear(index);
  }

  goToMonth(index) {
    EventCalendar.dateTime = EventCalendar.calendarProvider.goToMonth(index);
  }

  goToDay(index) {
    EventCalendar.dateTime = EventCalendar.calendarProvider.goToDay(index);
  }

  nextDay() {
    EventCalendar.dateTime =
        EventCalendar.calendarProvider.getNextDayDateTime();
  }

  previousDay() {
    EventCalendar.dateTime =
        EventCalendar.calendarProvider.getPreviousDayDateTime();
  }

  nextMonth() {
    EventCalendar.dateTime =
        EventCalendar.calendarProvider.getNextMonthDateTime();
  }

  previousMonth() {
    EventCalendar.dateTime =
        EventCalendar.calendarProvider.getPreviousMonthDateTime();
  }

  List getMonths() {
    return Translator().getMonthNames();
  }

  List getYears() => EventCalendar.calendarProvider.getYears();

  Map getDays() => EventCalendar.calendarProvider.getMonthDays();

  String getCurrentDateTime() => EventCalendar.calendarProvider.getDateTime();

  List<String> getDayNames() => EventCalendar.calendarProvider.getShortNameOfDays();

  getSelectedGregorianDate() {
    return DateTime.parse(EventCalendar.dateTime);
  }

  getPart({required PartFormat format, required String responseType}) {
    if (responseType == 'int') {
      return EventCalendar.calendarProvider.getDateTimePart(format);
    } else {
      return Translator().getPartTranslate(
          format, EventCalendar.calendarProvider.getDateTimePart(format) - 1);
    }
  }

}
