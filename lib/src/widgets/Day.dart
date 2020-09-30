import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';

class Day extends StatelessWidget {
  int index;
  String weekDay;
  bool selected;
  Function onCalendarChanged;

  Day({index, weekDay, selected, this.onCalendarChanged}) : super() {
    this.index = index;
    this.weekDay = weekDay;
    this.selected = selected;
  }

  List<Widget> child;
  double childWidth =
      EventCalendar.headerWeekDayStringType == 'full' ? 100 : 60;

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
            onCalendarChanged.call();
          }),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              CircleAvatar(
                child: Text(
                  '${index}',
                  style: TextStyle(
                    fontFamily: EventCalendar.font,
                  ),
                ),
                backgroundColor: selected
                    ? EventCalendar.dayIndexSelectedBackgroundColor
                    : EventCalendar.dayIndexUnselectedBackgroundColor,
                foregroundColor: selected
                    ? EventCalendar.dayIndexSelectedForegroundColor
                    : EventCalendar.dayIndexUnelectedForegroundColor,
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
}
