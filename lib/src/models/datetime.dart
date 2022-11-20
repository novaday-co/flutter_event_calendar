import 'package:flutter/material.dart';
import '../../flutter_event_calendar.dart';

class CalendarDateTime {
  int year;
  int month;
  int day;
  int? toMonth;
  int? toDay;
  int? hour;
  int? minute;
  int? second;
  bool isEnableDay;
  Color? color;
  CalendarType calendarType;

  CalendarDateTime(
      {required this.year,
      required this.month,
      required this.day,
      required this.calendarType,
      this.isEnableDay = true,
      this.toMonth,
      this.toDay,
      this.hour,
      this.minute,
      this.second,
      this.color});

  //supported format 1400-9-12 20:00(:50)
  static CalendarDateTime? parseDateTime(String dateTime, CalendarType calendarType) {
    final splitter = dateTime.split(" ");
    final datePart = splitter[0].split("-");
    final timePart = splitter[1].split(":");

    try {
      return CalendarDateTime(
          year: int.parse(datePart[0]),
          month: int.parse(datePart[1]),
          day: int.parse(datePart[2]),
          hour: int.parse(timePart[0]),
          minute: int.parse(timePart[1]),
          second: timePart.length == 3 ? double.parse(timePart[2]).toInt() : 0,
          calendarType: calendarType);
    } on Exception catch (e) {
      print("${e.toString()}");
      return null;
    }
  }

  //supported format 1400-9-12
  static CalendarDateTime? parseDate(String date, CalendarType calendarType) {
    final datePart = date.split("-");

    try {
      return CalendarDateTime(
          year: int.parse(datePart[0]),
          month: int.parse(datePart[1]),
          day: int.parse(datePart[2]),
          calendarType: calendarType);
    } on Exception catch (e) {
      print("${e.toString()}");
      return null;
    }
  }

  bool isDateEqual(CalendarDateTime dateTime) {
    return year == dateTime.year && month == dateTime.month && day == dateTime.day;
  }

  bool isDateEqualByInt(int year, int month, int day) {
    return this.year == year && this.month == month && this.day == day;
  }

  bool isDateTimeEqual(CalendarDateTime dateTime) {
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day &&
        hour == dateTime.hour &&
        minute == dateTime.minute;
  }

  @override
  String toString() {
    final fMonth = month < 10 ? "0$month" : "$month";
    final fDay = day < 10 ? "0$day" : "$day";
    if (hour != null && minute != null) {
      return "$year-$fMonth-$fDay $hour:$minute${second != null ? ':$second' : ''}";
    } else {
      return "$year-$fMonth-$fDay";
    }
  }

  String getDate() {
    final fMonth = month < 10 ? "0$month" : "$month";
    final fDay = day < 10 ? "0$day" : "$day";
    return "$year-$fMonth-$fDay";
  }

  DateTime toDateTime() {
    return DateTime(year, month, day);
  }
}
