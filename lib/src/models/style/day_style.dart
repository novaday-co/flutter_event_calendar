import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:scoped_model/scoped_model.dart';

class DayStyle extends Model{
  Color weekDaySelectedColor;
  Color weekDayUnselectedColor;
  Color dayIndexSelectedBackgroundColor;
  Color dayIndexUnselectedBackgroundColor;
  Color dayIndexSelectedForegroundColor;
  Color dayIndexUnelectedForegroundColor;
  Color dayEventCounterColor;
  DayEventCountViewType dayEventCounterViewType;
  Color dayEventCounterTextColor;

  DayStyle(
      {this.weekDaySelectedColor = const Color(0xff3AC3E2),
      this.weekDayUnselectedColor = Colors.black38,
      this.dayIndexSelectedBackgroundColor = const Color(0xff3AC3E2),
      this.dayIndexUnselectedBackgroundColor = Colors.transparent,
      this.dayIndexSelectedForegroundColor = Colors.white,
      this.dayIndexUnelectedForegroundColor = Colors.black,
      this.dayEventCounterColor =  Colors.orange,
      this.dayEventCounterViewType = DayEventCountViewType.LABEL,
      this.dayEventCounterTextColor = Colors.white});

  static DayStyle of(BuildContext context) =>
      ScopedModel.of<DayStyle>(context);

  bool equalTo(DayStyle dayStyle) {
    return (weekDaySelectedColor == dayStyle.weekDaySelectedColor) &&
        (weekDayUnselectedColor == dayStyle.weekDayUnselectedColor) &&
        (dayIndexSelectedBackgroundColor ==
            dayStyle.dayIndexSelectedBackgroundColor) &&
        (dayIndexUnselectedBackgroundColor ==
            dayStyle.dayIndexUnselectedBackgroundColor) &&
        (dayIndexSelectedForegroundColor ==
            dayStyle.dayIndexSelectedForegroundColor) &&
        (dayIndexUnelectedForegroundColor ==
            dayStyle.dayIndexUnelectedForegroundColor) &&
        (dayEventCounterColor == dayStyle.dayEventCounterColor) &&
        (dayEventCounterViewType == dayStyle.dayEventCounterViewType) &&
        (dayEventCounterTextColor == dayStyle.dayEventCounterTextColor);
  }
}
