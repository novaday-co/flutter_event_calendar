import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';

abstract class CalendarProvider {

  bool isRTL();
  Map getMonthDays(int index);
  Map getMonthDaysShort(int index);
  EDateTime getNextMonthDateTime();
  EDateTime getPreviousMonthDateTime();
  EDateTime getNextDayDateTime();
  EDateTime getPreviousDayDateTime();
  EDateTime getDateTime();
  String getMonthName(index);
  EDateTime goToMonth(index);
  EDateTime goToDay(index);
  EDateTime goToYear(int index);
  int getDateTimePart(PartFormat format);
  List<int> getYears();
  List<String> getNameOfDays() ;

}
