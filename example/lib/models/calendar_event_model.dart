import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:equatable/equatable.dart';

class CalendarEventModel extends Equatable {
  String calendarLanguage;
  CalendarType calendarType;
  CalendarOptions calendarOptions;
  HeaderOptions headerOptions;

  CalendarEventModel(
      {@required this.calendarLanguage,
      @required this.calendarType,
      @required this.calendarOptions,
      @required this.headerOptions});

  @override
  // TODO: implement props
  List<Object> get props =>
      [calendarLanguage, calendarType, calendarOptions.headerMonthBackColor];
}
