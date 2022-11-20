import 'package:flutter/material.dart';
import '../../../flutter_event_calendar.dart';
import 'package:scoped_model/scoped_model.dart';

class HeaderOptions extends Model {
  WeekDayStringTypes weekDayStringType;
  MonthStringTypes monthStringType;
  Color headerTextColor;
  Color navigationColor;
  Color resetDateColor;
  Color calendarIconColor;

  HeaderOptions(
      {this.weekDayStringType = WeekDayStringTypes.FULL,
      this.monthStringType = MonthStringTypes.SHORT,
      this.headerTextColor = Colors.black,
      this.resetDateColor = Colors.black,
      this.navigationColor = Colors.black,
      this.calendarIconColor = Colors.black,
      });

  static HeaderOptions of(BuildContext context) => ScopedModel.of<HeaderOptions>(context);
}
