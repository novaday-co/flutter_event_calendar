import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/handlers/EventSelector.dart';

class Day extends StatelessWidget {
  int index;
  String weekDay;
  bool selected;
  Function? onCalendarChanged;

  Day(
      {required this.index,
      required this.weekDay,
      required this.selected,
      this.onCalendarChanged})
      : super();

  late List<Widget> child;
  double childWidth =
      EventCalendar.headerWeekDayStringType == HeaderWeekDayStringTypes.Full
          ? 80
          : 60;

  late List<Event> todayEvents = EventSelector().getEventsForDayIndex(index);
  late Color textColor = selected
      ? EventCalendar.dayIndexSelectedForegroundColor
      : EventCalendar.dayIndexUnelectedForegroundColor;

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      childWidth = 35;
      child = [
        SizedBox(
          height: 15,
        ),
      ];
    } else {
      child = [
        InkWell(
          onTap: (() {
            CalendarSelector().goToDay(index);
            onCalendarChanged?.call();
          }),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '${weekDay}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected
                      ? EventCalendar.weekDaySelectedColor
                      : EventCalendar.weekDayUnselectedColor,
                  fontFamily: EventCalendar.font,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.all(EventCalendar.headerWeekDayStringType ==
                        HeaderWeekDayStringTypes.Full
                    ? 4
                    : 0),
                decoration: BoxDecoration(
                    color: selected
                        ? EventCalendar.dayIndexSelectedBackgroundColor
                        : EventCalendar.dayIndexUnselectedBackgroundColor,
                    shape: BoxShape.circle),
                constraints:
                    BoxConstraints(minWidth: double.infinity, minHeight: 45),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '$index',
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: EventCalendar.dayEventCountViewType ==
                                DayEventCountViewType.DOT
                            ? dotMaker()
                            : labelMaker(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ];
    }

    return Container(
      padding: EdgeInsets.all(10),
      width: childWidth,
      child: Column(children: child),
    );
  }

  dotMaker() {
    List<Widget> widgets = [];
    final maxDot = min(todayEvents.length, 3);
    for (int i = 0; i < maxDot; i++) {
      widgets.add(
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: EventCalendar.dayEventCountColor,
          ),
        ),
      );
      if (i != maxDot - 1)
        widgets.add(SizedBox(
          width: 2,
        ));
    }
    return widgets;
  }

  labelMaker() {
    if (todayEvents.isEmpty) return [Container()];
    return [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: EventCalendar.dayEventCountColor,
        ),
        child: Text(
          "${todayEvents.length >= 10 ? '+9' : todayEvents.length}",
          style: TextStyle(
              fontSize: 10,
              fontFamily: EventCalendar.font,
              color: EventCalendar.dayEventCountTextColor),
        ),
      )
    ];
  }
}
