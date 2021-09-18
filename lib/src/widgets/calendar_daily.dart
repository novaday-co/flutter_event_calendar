import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:flutter_event_calendar/src/handlers/event_selector.dart';
import 'package:flutter_event_calendar/src/models/style/headers_style.dart';
import 'package:flutter_event_calendar/src/widgets/day.dart';

class CalendarDaily extends StatelessWidget {
  Function? onCalendarChanged;
  var dayIndex;
  late ScrollController animatedTo;
  EventSelector selector = EventSelector();
  List<EventDateTime> enabledDays;
  List<EventDateTime> disabledDays;
  List<EventDateTime> colorizedDays;

  CalendarDaily(
      {this.onCalendarChanged,
      required this.enabledDays,
      required this.colorizedDays,
      required this.disabledDays})
      : super() {
    dayIndex =
        CalendarUtils.getPartByInt(format: PartFormat.day);
  }

  @override
  Widget build(BuildContext context) {
    animatedTo = ScrollController(
        initialScrollOffset:
            (HeadersStyle.of(context).weekDayStringType ==
                        WeekDayStringTypes.Full
                    ? 80.0
                    : 60.0) *
                (dayIndex - 1));

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      animatedTo.animateTo(
          (HeadersStyle.of(context).weekDayStringType ==
                      WeekDayStringTypes.Full
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
                    children: daysMaker(context),
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

  List<Widget> daysMaker(BuildContext context) {
    final currentMonth =
        CalendarUtils.getPartByInt(format: PartFormat.month);
    final currentYear =
        CalendarUtils.getPartByInt(format: PartFormat.year);

    final headersStyle = HeadersStyle.of(context);

    List<Widget> days = [
      SizedBox(
          width: headersStyle.weekDayStringType ==
                  WeekDayStringTypes.Full
              ? 80
              : 60)
    ];

    int day = dayIndex;

    CalendarUtils.getDays(headersStyle.weekDayStringType, currentMonth)
        .forEach((index, weekDay) {
      final isEnable = isEnabledDay(currentYear, currentMonth, index) &&
          !isDisabledDay(currentYear, currentMonth, index);

      var selected = index == day ? true : false;
      days.add(Day(
        day: index,
        dayEvents: selector.getEventsByDayMonthYear(
            EventDateTime(year: currentYear, month: currentMonth, day: index)),
        mini: false,
        enabled: isEnable,
        weekDay: weekDay,
        selected: selected,
        onCalendarChanged: () {
          CalendarUtils.goToDay(index);
          onCalendarChanged?.call();
        },
      ));
    });

    days.add(SizedBox(
        width: headersStyle.weekDayStringType ==
                WeekDayStringTypes.Full
            ? 80
            : 60));

    return days;
  }

  bool isEnabledDay(int cYear, int cMonth, int day) {
    if (enabledDays.isEmpty) return true;
    return enabledDays
            .where(
              (element) =>
                  element.year == cYear &&
                  element.month == cMonth &&
                  element.day == day,
            )
            .length !=
        0;
  }

  bool isDisabledDay(cYear, cMonth, int day) {
    return disabledDays
            .where(
              (element) =>
                  element.year == cYear &&
                  element.month == cMonth &&
                  element.day == day,
            )
            .length !=
        0;
  }
}
