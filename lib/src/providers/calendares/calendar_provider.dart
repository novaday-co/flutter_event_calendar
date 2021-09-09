import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';

abstract class CalendarProvider {

  bool isRTL();

  /// month direction configs
  String getNextMonthDateTime();

  String getPreviousMonthDateTime();

  /// day direction config
  String getNextDayDateTime();

  String getPreviousDayDateTime();

  String getDateTime();

  /// Month configs
  List<int> getYears();

  Map getMonthDays(int index);

  Map getMonthDaysShort(int index);

  String getMonthName(index);

  /// goto methods
  String goToMonth(index);

  String goToDay(index);

  String goToYear(int index);

  /// part methods
  int getDateTimePart(PartFormat format);

}
