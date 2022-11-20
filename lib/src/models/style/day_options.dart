import 'package:flutter/material.dart';
import '../../../flutter_event_calendar.dart';
import 'package:scoped_model/scoped_model.dart';

class DayOptions extends Model {
  Color weekDaySelectedColor;
  Color weekDayUnselectedColor;
  bool showWeekDay;
  bool compactMode;
  Color selectedBackgroundColor;
  Color unselectedBackgroundColor;
  Color selectedTextColor;
  Color disabledTextColor;
  Color unselectedTextColor;
  Color eventCounterColor;
  DayEventCounterViewType eventCounterViewType;
  Color eventCounterTextColor;
  bool disableFadeEffect;
  bool disableDaysBeforeNow;
  double dayFontSize;

  DayOptions({
    this.weekDaySelectedColor = Colors.red,
    this.weekDayUnselectedColor = Colors.black38,
    this.selectedBackgroundColor = const Color(0xff3AC3E2),
    this.unselectedBackgroundColor = Colors.transparent,
    this.selectedTextColor = Colors.white,
    this.showWeekDay = true,
    this.compactMode = false,
    this.disableDaysBeforeNow = false,
    this.disableFadeEffect = false,
    this.disabledTextColor = Colors.grey,
    this.unselectedTextColor = Colors.black,
    this.eventCounterColor = Colors.red,
    this.eventCounterViewType = DayEventCounterViewType.LABEL,
    this.eventCounterTextColor = Colors.white,
    this.dayFontSize = 12,
  });

  static DayOptions of(BuildContext context) => ScopedModel.of<DayOptions>(context);
}
