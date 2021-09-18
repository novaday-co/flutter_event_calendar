import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:scoped_model/scoped_model.dart';

class HeadersStyle extends Model {
  WeekDayStringTypes weekDayStringType;
  MonthStringTypes monthStringType;

  HeadersStyle({
    this.weekDayStringType = WeekDayStringTypes.Full,
    this.monthStringType = MonthStringTypes.Short,
  });

  static HeadersStyle of(BuildContext context) =>
      ScopedModel.of<HeadersStyle>(context);
}
