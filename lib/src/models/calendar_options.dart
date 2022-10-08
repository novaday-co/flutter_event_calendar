import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:scoped_model/scoped_model.dart';

class CalendarOptions extends Model {
  bool toggleViewType;
  ViewType viewType;
  String font;
  Color? headerMonthBackColor;
  Color? headerMonthShadowColor;
  double? headerMonthElevation;
  ShapeBorder? headerMonthShape;
  bool isMultiSelection=false;
  CalendarOptions(
      {this.toggleViewType = false,
      this.viewType = ViewType.MONTHLY,
      this.headerMonthBackColor,
      this.headerMonthShadowColor,
      this.headerMonthElevation,
      this.headerMonthShape,
      this.font = ''});

  static CalendarOptions of(BuildContext context) =>
      ScopedModel.of<CalendarOptions>(context);
}
