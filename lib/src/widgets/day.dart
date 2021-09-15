import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/event_calendar.dart';
import 'package:flutter_event_calendar/src/models/calendar_options.dart';

class Day extends StatelessWidget {
  String weekDay;
  bool selected;
  Function? onCalendarChanged;
  bool mini;
  bool useUnselectedEffect;
  bool enabled;
  List<Event> dayEvents;
  int day;
  Color? color;
  late DayStyle dayStyle;
  Day(
      {required this.day,
      required this.weekDay,
      required this.selected,
      required this.dayEvents,
      this.color,
      this.enabled = true,
      this.useUnselectedEffect = false,
      this.mini = true,
      this.onCalendarChanged})
      : super();

  late Widget child;

  late Color textColor;

  @override
  Widget build(BuildContext context) {
    dayStyle = DayStyle.of(context);

    textColor = selected
        ? dayStyle.dayIndexSelectedForegroundColor
        : (_shouldHaveTransparentColor()
            ? (color ?? dayStyle.dayIndexUnelectedForegroundColor)
                .withOpacity(0.3)
            : (color ?? dayStyle.dayIndexUnelectedForegroundColor));

    child = InkWell(
      onTap: (() {
        if (enabled) onCalendarChanged?.call();
      }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (!mini)
            Text(
              '$weekDay',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: _getTitleColor(),
                fontFamily: CalendarOptions.of(context).font,
              ),
            ),
          if (!mini)
            SizedBox(
              height: 8,
            ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
            padding: mini
                ? EdgeInsets.all(0)
                : (EdgeInsets.all(EventCalendar.headerWeekDayStringType ==
                        HeaderWeekDayStringTypes.Full
                    ? 4
                    : 0)),
            decoration: BoxDecoration(
                color: selected
                    ? dayStyle.dayIndexSelectedBackgroundColor
                    : dayStyle.dayIndexUnselectedBackgroundColor,
                shape: BoxShape.circle),
            constraints: BoxConstraints(
                minWidth: double.infinity, minHeight: mini ? 35 : 45),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '$day',
                    style: TextStyle(
                      color: textColor,
                      fontFamily: CalendarOptions.of(context).font,
                    ),
                  ),
                ),
                Align(
                  alignment: dayStyle.dayEventCounterViewType ==
                          DayEventCountViewType.DOT
                      ? Alignment.bottomCenter
                      : Alignment.bottomRight,
                  child: dayStyle.dayEventCounterViewType ==
                          DayEventCountViewType.DOT
                      ? dotMaker()
                      : labelMaker(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // }

    return Container(
      padding: EdgeInsets.all(mini ? 0 : 10),
      width: mini
          ? 45
          : (EventCalendar.headerWeekDayStringType ==
                  HeaderWeekDayStringTypes.Full
              ? 80
              : 60),
      child: child,
    );
  }

  dotMaker() {
    List<Widget> widgets = [];

    final maxDot = min(dayEvents.length, 3);
    for (int i = 0; i < maxDot; i++) {
      widgets.add(
        Container(
          margin: EdgeInsets.only(
              bottom: EventCalendar.headerWeekDayStringType ==
                      HeaderWeekDayStringTypes.Short
                  ? (mini ? 4 : 8)
                  : 2),
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _shouldHaveTransparentColor()
                ? dayStyle.dayEventCounterColor.withOpacity(0.4)
                : dayStyle.dayEventCounterColor,
          ),
        ),
      );
      if (i != maxDot - 1)
        widgets.add(
          SizedBox(
            width: 2,
          ),
        );
    }
    return Row(mainAxisSize: MainAxisSize.min, children: widgets);
  }

  labelMaker(BuildContext context) {
    if (dayEvents.isEmpty) return Container();
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _shouldHaveTransparentColor()
            ? dayStyle.dayEventCounterColor.withOpacity(0.3)
            : dayStyle.dayEventCounterColor,
      ),
      child: Text(
        "${dayEvents.length >= 10 ? '+9' : dayEvents.length}",
        style: TextStyle(
            fontSize: 10,
            fontFamily: CalendarOptions.of(context).font,
            color: useUnselectedEffect
                ? dayStyle.dayEventCounterTextColor.withOpacity(0.3)
                : dayStyle.dayEventCounterTextColor),
      ),
    );
  }

  _getTitleColor() {
    print("color is $color");
    return selected
        ? dayStyle.weekDaySelectedColor
        : (color != null ? color : dayStyle.weekDayUnselectedColor);
  }

  _shouldHaveTransparentColor() {
    return useUnselectedEffect || !enabled;
  }
}
