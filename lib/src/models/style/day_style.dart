import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:scoped_model/scoped_model.dart';

class DayStyle extends Model{
  Color weekDaySelectedColor;
  Color weekDayUnselectedColor;
  Color selectedBackgroundColor;
  Color unselectedBackgroundColor;
  Color selectedTextColor;
  Color unselectedTextColor;
  Color eventCounterColor;
  DayEventCountViewType eventCounterViewType;
  Color eventCounterTextColor;

  DayStyle(
      {this.weekDaySelectedColor = Colors.red,
      this.weekDayUnselectedColor = Colors.black38,
      this.selectedBackgroundColor = const Color(0xff3AC3E2),
      this.unselectedBackgroundColor = Colors.transparent,
      this.selectedTextColor = Colors.white,
      this.unselectedTextColor = Colors.black,
      this.eventCounterColor =  Colors.red,
      this.eventCounterViewType = DayEventCountViewType.LABEL,
      this.eventCounterTextColor = Colors.white});

  static DayStyle of(BuildContext context) =>
      ScopedModel.of<DayStyle>(context);

}
