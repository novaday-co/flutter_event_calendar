import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/widgets/Day.dart';

class CalendarDaily extends StatelessWidget {
  Function? onCalendarChanged;
  var dayIndex;
  late ScrollController animatedTo;

  CalendarDaily({this.onCalendarChanged}) : super() {
    dayIndex =
        CalendarSelector().getPart(format: PartFormat.day, responseType: 'int');
  }

  @override
  Widget build(BuildContext context) {
    animatedTo = ScrollController(
        initialScrollOffset: (EventCalendar.headerWeekDayStringType ==
                    HeaderWeekDayStringTypes.Full
                ? 80.0
                : 60.0) *
            (dayIndex - 1));
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      animatedTo.animateTo(
          (EventCalendar.headerWeekDayStringType ==
                      HeaderWeekDayStringTypes.Full
                  ? 80.0
                  : 60.0) *
              (dayIndex - 1),
          duration: Duration(milliseconds: 700),
          curve: Curves.decelerate);
    });

    // Yearly , Monthly , Weekly and Daily calendar
    return Container(
      height: 130,
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListView(
                    reverse: EventCalendar.calendarProvider.isRTL(),
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
    final currentMonth = CalendarSelector()
        .getPart(format: PartFormat.month, responseType: 'int');
    final currentYear = CalendarSelector()
        .getPart(format: PartFormat.year, responseType: 'int');

    List<Widget> days = [
      SizedBox(
          width: EventCalendar.headerWeekDayStringType ==
                  HeaderWeekDayStringTypes.Full
              ? 80
              : 60)
    ];

    int day = dayIndex;

    CalendarSelector().getDays(currentMonth).forEach((index, weekDay) {
      var selected = index == day ? true : false;
      days.add(Day(
        dayIndex: index,
        year: currentYear,
        mini: false,
        month: currentMonth,
        weekDay: weekDay,
        selected: selected,
        onCalendarChanged: () {
          CalendarSelector().goToDay(index);
          onCalendarChanged?.call();
        },
      ));
    });

    days.add(SizedBox(
        width: EventCalendar.headerWeekDayStringType ==
                HeaderWeekDayStringTypes.Full
            ? 80
            : 60));

    return days;
  }
}
