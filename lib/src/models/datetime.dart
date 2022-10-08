import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:shamsi_date/extensions.dart';
import 'package:shamsi_date/shamsi_date.dart';


class CalendarDateTime {
  int year;
  int month;
  int day;
  int? daysInMonth;
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
        this.color,
        this.daysInMonth});

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

  static CalendarDateTime? parseDateTimeToCalendarTime(DateTime date,CalendarType calendarType) {
    return CalendarDateTime(
        year: date.year,
        month: date.month,
        day: date.day,
        calendarType: calendarType);

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

  static List<CalendarDateTime> getDayListCurrentMonth(
      CalendarDateTime startDate,
      CalendarDateTime endDate,
      ) {
    if (startDate.calendarType == CalendarType.JALALI) {
      return getDayListJalaliDays(
          startDate, endDate);
    } else {
      return getDayListGregorianDays(startDate,endDate);
    }
  }


  static List<CalendarDateTime> getDayListJalaliDays(CalendarDateTime startDate,
      CalendarDateTime endDate) {
    List<CalendarDateTime> days = [];
    int counter = 0;
    int day = startDate.day;
    int year = startDate.year;
    int month = startDate.month;
    int currentMonthDays = monthLength(month, year);
    int difference= Jalali(startDate.year, startDate.month, startDate.day).distanceTo(Jalali(endDate.year, endDate.month, endDate.day));
    for (int index = day; counter <= difference; index++) {
      counter++;
      if(index > currentMonthDays){
        month=month+1;
        if(month==13){
          month=1;
          year=year+1;
          index=1;
          currentMonthDays = monthLength(month,year);
        }else if(month<=12 ){
          index=1;
          currentMonthDays = monthLength(month,year);
        }

      }

      days.add(CalendarDateTime(
          year: year,
          month: month,
          day:index,
          calendarType: CalendarType.JALALI));


    }
    return days;


  }

  static List<CalendarDateTime> getDayListGregorianDays(
      CalendarDateTime startDate,
      CalendarDateTime endDate,) {
    List<CalendarDateTime> days = [];

    for (int i = 0; i <= endDate.toDateTime().difference(startDate.toDateTime()).inDays; i++) {
      days.add( CalendarDateTime.parseDateTime(startDate.toDateTime().add(Duration(days: i)).toString(), CalendarUtils.getCalendarType())! );
    }

    return days;
  }


  static int  monthLength(int month,int year ) {
    if (month <= 6) {
      return 31;
    } else if (month <= 11) {
      return 30;
    } else {
      // month == 12
      return Jalali(year).isLeapYear() ? 30 : 29;
    }
  }
}




