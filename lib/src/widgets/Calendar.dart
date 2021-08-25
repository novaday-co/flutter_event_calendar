import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/widgets/Day.dart';

class Calendar extends StatelessWidget {
  Function? onCalendarChanged;
  var dayIndex;
  late ScrollController animatedTo;

  Calendar({this.onCalendarChanged}) : super() {
    dayIndex = CalendarSelector().getPart(format: 'day', responseType: 'int');
  }

  @override
  Widget build(BuildContext context) {
    animatedTo = ScrollController(
        initialScrollOffset:
            (EventCalendar.headerWeekDayStringType == 'full' ? 100.0 : 52.0) *
                (dayIndex - 1));
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      animatedTo.animateTo(
          (EventCalendar.headerWeekDayStringType == 'full' ? 100.0 : 52.0) *
              (dayIndex - 1),
          duration: Duration(milliseconds: 700),
          curve: Curves.decelerate);
    });

    // Yearly , Monthly , Weekly and Daily calendar
    return Container(
      height: 130,
      child: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 10),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListView(
                    reverse: EventCalendar.isRTL,
                    controller: animatedTo,
                    scrollDirection: Axis.horizontal,
                    children: daysMaker(),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IgnorePointer(
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color(0xffffffff),
                        const Color(0x0affffff)
                      ],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IgnorePointer(
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        const Color(0xffffffff),
                        const Color(0x0affffff)
                      ],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> daysMaker() {
    List<Widget> days = [
      Day(
        index: 0,
        weekDay: '',
        selected: false,
        onCalendarChanged: onCalendarChanged,
      )
    ];

    int day = dayIndex;

    CalendarSelector().getDays().forEach((index, weekDay) {
      var selected = index == day ? true : false;
      days.add(Day(
        index: index,
        weekDay: weekDay,
        selected: selected,
        onCalendarChanged: onCalendarChanged,
      ));
    });

    days.add(Day(
      index: 0,
      weekDay: '',
      selected: false,
      onCalendarChanged: onCalendarChanged,
    ));

    return days;
  }
}
