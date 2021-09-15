import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:scoped_model/scoped_model.dart';

class CalendarOptions extends Model{
  bool selectableViewType;
  CalendarViewType calendarViewType;
  String font;

  CalendarOptions({
    this.selectableViewType = false,
      this.calendarViewType = CalendarViewType.Monthly,
      this.font = ''});

  static CalendarOptions of(BuildContext context) =>
      ScopedModel.of<CalendarOptions>(context);
}
