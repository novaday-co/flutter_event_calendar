import 'package:flutter/material.dart';

class EventDateTime {
  int year;
  int month;
  int day;
  int? hour;
  int? minute;
  int? second;
  Color? color;

  EventDateTime(
      {required this.year,
      required this.month,
      required this.day,
      this.hour,
      this.minute,
      this.second,
      this.color});

  //supported format 1400-9-12 20:00(:50)
  static EventDateTime? parse(String dateTime) {
    final splitter = dateTime.split(" ");
    final datePart = splitter[0].split("-");
    final timePart = splitter[1].split(":");

    try {
      return EventDateTime(
        year: int.parse(datePart[0]),
        month: int.parse(datePart[1]),
        day: int.parse(datePart[2]),
        hour: int.parse(timePart[0]),
        minute: int.parse(timePart[1]),
        second: timePart.length == 3 ? double.parse(timePart[2]).toInt() : 0,
      );
    } on Exception catch (e) {
      return null;
    }
  }

  bool isDateEqual(EventDateTime dateTime) {
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day;
  }

  bool isDateEqualByInt(int year, int month, int day) {
    return this.year == year && this.month == month && this.day == day;
  }

  bool isDateTimeEqual(EventDateTime dateTime) {
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day &&
        hour == dateTime.hour &&
        minute == dateTime.minute;
  }

  @override
  String toString() {
    if (hour != null && minute != null) {
      return "$year/$month/$day $hour:$minute${second != null ? ':$second' : ''}";
    } else
      return "$year/$month/$day";
  }
}
