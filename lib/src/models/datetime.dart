import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:shamsi_date/shamsi_date.dart';

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
  static CalendarDateTime? parseDateTime(
      String dateTime, CalendarType calendarType) {
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
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day;
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
  String toString({CalendarType? calendarType}) {
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
  CalendarDateTime toGregorianDate() {
    if (calendarType == CalendarType.JALALI) {
      Jalali jalali = Jalali(year, month, day);
      DateTime dateTime = jalali.toDateTime();
      return CalendarDateTime(
          year: dateTime.year,
          month: dateTime.month,
          day: dateTime.day,
          calendarType: calendarType);
    } else {
      return this;
    }
  }

  String getDateByType(CalendarType? calendarType) {
    Jalali date;
    if ((calendarType ?? CalendarType.GREGORIAN) == CalendarType.GREGORIAN) {
      return toString();
    } else {
      date = Jalali.fromDateTime(toDateTime());
      return CalendarDateTime(
          year: date.year,
          month: date.month,
          day: date.day,
          calendarType: calendarType!)
          .toString();
    }
  }
}

extension DateFormatter on CalendarDateTime {
  CalendarDateTime get gregorianDate {
    if (calendarType == CalendarType.JALALI) {
      Jalali jalali = Jalali(year, month, day);
      DateTime dateTime = jalali.toDateTime();
      return CalendarDateTime(
          year: dateTime.year,
          month: dateTime.month,
          day: dateTime.day,
          calendarType: calendarType);
    } else {
      return this;
    }
  }

  CalendarDateTime convertDateByCalendarType(CalendarType calendarType) {
    switch (calendarType) {
      case CalendarType.JALALI:
        DateTime date = DateTime(year, month, day, hour ?? 0, minute ?? 0);
        Jalali jalali = Jalali.fromDateTime(date);
        return CalendarDateTime(
            year: jalali.year,
            month: jalali.month,
            day: jalali.day,
            // hour: jalali.hour,
            // minute: jalali.minute,
            calendarType: CalendarType.JALALI);
      case CalendarType.GREGORIAN:
        Jalali jalali = Jalali(year, month, day);
        DateTime dateTime = jalali.toDateTime();
        return CalendarDateTime(
            year: dateTime.year,
            month: dateTime.month,
            day: dateTime.day,
            calendarType: CalendarType.GREGORIAN);
    }
  }
}
