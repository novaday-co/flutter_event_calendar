import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/utils/types/calendar_types.dart';

abstract class CalendarProvider {
  bool isRTL();

  //// month direction configs ////
  String getNextMonthDateTime();

  String getPreviousMonthDateTime();

  //// day direction config ////
  String getNextDayDateTime();

  String getPreviousDayDateTime();

  String getDateTime();

  //// Day configs ////
  List<String> getShortNameOfDays();

  List<String> getFullNameOfDays();

  //// Month configs ////
  List<String> getFullMonthNames();

  List<String> getShortMonthNames();

  List<int> getYears();

  Map getMonthDays(int index);

  Map getMonthDaysShort(int index);

  String getMonthName(index);

  /// goto methods ///
  String goToMonth(index);

  String goToDay(index);

  String goToYear(int index);

  /// part methods ///
  int getDateTimePart(PartFormat format);

}
