import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:equatable/equatable.dart';

class CalendarEventModel extends Equatable {
  String calendarLanguage;
  CalendarType calendarType;
  CalendarOptions calendarOptions;
  HeaderOptions headerOptions;
  DayOptions dayOptions;
  List<CalendarDateTime> specialDays;
  CalendarEventModel(
      {required this.calendarLanguage,
      required this.calendarType,
      required this.calendarOptions,
      required this.headerOptions,
      required this.dayOptions,
        required this.specialDays
      });

  @override

  List<Object> get props =>
      [specialDays];
}

