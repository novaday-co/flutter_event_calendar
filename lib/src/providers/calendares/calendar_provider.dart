import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';

abstract class CalendarProvider {

  bool isRTL();
  Map getMonthDays(int index);
  Map getMonthDaysShort(int index);
  String getNextMonthDateTime();
  String getPreviousMonthDateTime();
  String getNextDayDateTime();
  String getPreviousDayDateTime();
  String getDateTime();
  String getMonthName(index);
  String goToMonth(index);
  String goToDay(index);
  String goToYear(int index);
  int getDateTimePart(PartFormat format);
  List<int> getYears();
  List<String> getNameOfDays() ;

}
