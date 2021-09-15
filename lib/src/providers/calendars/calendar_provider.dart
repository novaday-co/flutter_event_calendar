import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';

abstract class CalendarProvider {
  bool isRTL();

  Map getMonthDays(WeekDayStringTypes type,int index);

  Map getMonthDaysShort(int index);

  EventDateTime getNextMonthDateTime();

  EventDateTime getPreviousMonthDateTime();

  EventDateTime getNextDayDateTime();

  EventDateTime getPreviousDayDateTime();

  EventDateTime getDateTime();

  EventDateTime goToMonth(index);

  EventDateTime goToDay(index);

  EventDateTime goToYear(int index);

  int getDateTimePart(PartFormat format);

  List<int> getYears();
}
