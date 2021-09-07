import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/handlers/EventSelector.dart';

class Day extends StatelessWidget {
  int dayIndex;
  int month;
  int year;
  String weekDay;
  bool selected;
  Function? onCalendarChanged;
  bool mini;
  bool useUnselectedEffect;

  Day(
      {required this.month,
      required this.dayIndex,
      required this.year,
      required this.weekDay,
      required this.selected,
      this.useUnselectedEffect = false,
      this.mini = true,
      this.onCalendarChanged})
      : super();

  late Widget child;

  late List<Event> todayEvents =
      EventSelector().getEventsByDayMonthYear(year, month, dayIndex);
  late Color textColor = selected
      ? EventCalendar.dayIndexSelectedForegroundColor
      : (useUnselectedEffect
          ? EventCalendar.dayIndexUnelectedForegroundColor.withOpacity(0.2)
          : EventCalendar.dayIndexUnelectedForegroundColor);

  @override
  Widget build(BuildContext context) {
    child = InkWell(
      onTap: (() {
        onCalendarChanged?.call();
      }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (!mini)
            Text(
              '$weekDay',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: selected
                    ? EventCalendar.weekDaySelectedColor
                    : EventCalendar.weekDayUnselectedColor,
                fontFamily: EventCalendar.font,
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
                    ? EventCalendar.dayIndexSelectedBackgroundColor
                    : EventCalendar.dayIndexUnselectedBackgroundColor,
                shape: BoxShape.circle),
            constraints: BoxConstraints(
                minWidth: double.infinity, minHeight: mini ? 35 : 45),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '$dayIndex',
                    style: TextStyle(
                      color: textColor,
                      fontFamily: EventCalendar.font,
                    ),
                  ),
                ),
                Align(
                  alignment: EventCalendar.dayEventCountViewType ==
                          DayEventCountViewType.DOT
                      ? Alignment.bottomCenter
                      : Alignment.bottomRight,
                  child: EventCalendar.dayEventCountViewType ==
                          DayEventCountViewType.DOT
                      ? dotMaker()
                      : labelMaker(),
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

    final maxDot = min(todayEvents.length, 3);
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
            color: useUnselectedEffect
                ? EventCalendar.dayEventCountColor.withOpacity(0.4)
                : EventCalendar.dayEventCountColor,
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

  labelMaker() {
    if (todayEvents.isEmpty) return Container();
    return Container(
    margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: useUnselectedEffect ? EventCalendar.dayEventCountColor.withOpacity(0.3) : EventCalendar.dayEventCountColor,
      ),
      child: Text(
        "${todayEvents.length >= 10 ? '+9' : todayEvents.length}",
        style: TextStyle(
            fontSize: 10,
            fontFamily: EventCalendar.font,
            color: useUnselectedEffect ? EventCalendar.dayEventCountTextColor.withOpacity(0.3) : EventCalendar.dayEventCountTextColor),
      ),
    );
  }
}
