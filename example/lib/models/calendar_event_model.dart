import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:equatable/equatable.dart';

class CalendarEventModel extends Equatable {
  String calendarLanguage;
  CalendarType calendarType;
  //map
  //Map<String,CalendarType> calendarType;
  CalendarOptions calendarOptions;
  HeaderOptions headerOptions;
  DayOptions dayOptions;

  CalendarEventModel(
      {required this.calendarLanguage,
      required this.calendarType,
      required this.calendarOptions,
      required this.headerOptions,
      required this.dayOptions
      });

  @override
  // TODO: implement props
  List<Object> get props =>
      [calendarLanguage, calendarType,calendarOptions];
}

extension CalendarTypes on CalendarType{
    String calendarTypeToString(CalendarType calendarType){
      switch ( calendarType){
        case CalendarType.JALALI:   return "Jalali";
        case CalendarType.GREGORIAN:  return "GREGORIAN";
        default: return "errorOnCalendarType";
      }
  }

  //groupKey => coli

    CalendarType strignToCalendarType(String calendarTypeStrign){
      switch ( calendarTypeStrign){
        case "Jalali":   return CalendarType.JALALI;
        case "GREGORIAN":  return CalendarType.JALALI;
        default: return CalendarType.values.first;
      }
    }
}