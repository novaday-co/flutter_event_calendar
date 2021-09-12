import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:flutter_event_calendar/src/handlers/event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/event_selector.dart';
import 'package:flutter_event_calendar/src/handlers/translator.dart';
import 'package:flutter_event_calendar/src/models/date.dart';
import 'package:flutter_event_calendar/src/widgets/Day.dart';

class CalendarMonthly extends StatefulWidget {
  Function onCalendarChanged;
  List<Date> enabledDays;
  List<Date> disabledDays;

  CalendarMonthly(
      {required this.enabledDays,
      required this.disabledDays,
      required this.onCalendarChanged,
      Key? key})
      : super();

  @override
  State<CalendarMonthly> createState() => _CalendarMonthlyState();
}

class _CalendarMonthlyState extends State<CalendarMonthly> {
  List<String> dayNames = Translator.getShortNameOfDays();
  CalendarUtils calendarSelector = CalendarUtils();
  EventSelector eventSelector = EventSelector();
  int currDay = -1;
  int currMonth = -1;

  @override
  void didChangeDependencies() {
    currDay =
        calendarSelector.getPart(format: PartFormat.day, responseType: 'int');
    currMonth =
        calendarSelector.getPart(format: PartFormat.month, responseType: 'int');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CalendarMonthly oldWidget) {
    dayNames = Translator.getShortNameOfDays();
    currDay =
        calendarSelector.getPart(format: PartFormat.day, responseType: 'int');
    currMonth =
        calendarSelector.getPart(format: PartFormat.month, responseType: 'int');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_buildDayName(), _buildMonthView()],
      ),
    );
  }

  _buildDayName() {
    return Row(
      textDirection: EventCalendar.calendarProvider.isRTL()
          ? TextDirection.rtl
          : TextDirection.ltr,
      children: List.generate(
        7,
        (index) => Expanded(
          child: Center(
            heightFactor: 2,
            child: Text(
              dayNames[index],
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: EventCalendar.font),
            ),
          ),
        ),
      ),
    );
  }

  _buildMonthView() {
    final int firstDayIndex = getFirstDayOfMonth();
    final int lastDayIndex = firstDayIndex + getLastDayOfMonth();
    final lastMonthLastDay = getLastMonthLastDay();

    return SizedBox(
      height: 7 * 40,
      child: Directionality(
        textDirection: EventCalendar.calendarProvider.isRTL()
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 42,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, mainAxisExtent: 45),
            itemBuilder: (context, index) => _buildItem(
                index, firstDayIndex, lastDayIndex, lastMonthLastDay)),
      ),
    );
  }

  _buildItem(
      int index, int firstDayIndex, int lastDayIndex, int lastMonthLastDay) {
    int day = -1;

    final isCurrentMonthDays = index >= firstDayIndex && index < lastDayIndex;
    final isNextMonthDays = index >= lastDayIndex;

    if (isCurrentMonthDays)
      day = index - firstDayIndex + 1;
    else if (isNextMonthDays)
      day = index - lastDayIndex + 1;
    else
      day = lastMonthLastDay - (firstDayIndex - index) + 1;

    if (isCurrentMonthDays) {
      return buildCurrentMonthDay(day);
    } else if (isNextMonthDays) {
      return buildNextMonthDay(day);
    } else if (day > 0) {
      return buildPrevMonthDay(day);
    }
    return SizedBox();
  }

  int getFirstDayOfMonth() {
    final currentMonth =
        calendarSelector.getPart(format: PartFormat.month, responseType: 'int');
    final monthDays = calendarSelector.getMonthDaysShort(currentMonth);
    return dayNames.indexOf(monthDays[1]);
  }

  int getLastDayOfMonth() {
    final currentMonth =
        calendarSelector.getPart(format: PartFormat.month, responseType: 'int');
    return calendarSelector.getDays(currentMonth).keys.last;
  }

  int getLastMonthLastDay() {
    final cMonth =
        calendarSelector.getPart(format: PartFormat.month, responseType: 'int');
    if (cMonth - 1 < 1) {
      return -1;
    }
    return calendarSelector.getDays(cMonth - 1).keys.last;
  }

  getMonth(int month) {
    if (month > 12)
      return 1;
    else if (month < 1) return 1;
    return month;
  }

  getYear(int month) {
    final year =
        calendarSelector.getPart(format: PartFormat.year, responseType: 'int');
    if (month > 12)
      return year + 1;
    else if (month < 1) return year - 1;
    return year;
  }

  bool isEnabledDay(int cYear, int cMonth, int day) {
    if (widget.enabledDays.isEmpty) return true;
    return widget.enabledDays
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
    return widget.disabledDays
            .where(
              (element) =>
                  element.year == cYear &&
                  element.month == cMonth &&
                  element.day == day,
            )
            .length !=
        0;
  }

  buildCurrentMonthDay(day) {
    final curYear = getYear(currMonth);
    final isEnable = isEnabledDay(curYear, currMonth, day) &&
        !isDisabledDay(curYear, currMonth, day);

    return Center(
      child: Day(
        dayEvents: eventSelector.getEventsByDayMonthYear(
          EventDateTime(year: curYear, month: currMonth, day: day),
        ),
        day: day,
        weekDay: '',
        enabled: isEnable,
        selected: day == currDay,
        onCalendarChanged: () {
          calendarSelector.goToDay(day);
          widget.onCalendarChanged.call();
        },
        mini: true,
      ),
    );
  }

  buildNextMonthDay(int day) {
    final year = getYear(currMonth + 1);
    final month = getMonth(currMonth + 1);
    final isEnable =
        isEnabledDay(year, month, day) && !isDisabledDay(year, month, day);

    return Center(
        child: Day(
            day: day,
            useUnselectedEffect: true,
            weekDay: '',
            dayEvents: eventSelector.getEventsByDayMonthYear(EventDateTime(
                year: year, month: getMonth(currMonth + 1), day: day)),
            enabled: isEnable,
            onCalendarChanged: () {
              // reset to first to fix switching between 31/30/29 month lengths
              calendarSelector.goToDay(1);
              calendarSelector.nextMonth();
              calendarSelector.goToDay(day);
              widget.onCalendarChanged.call();
            },
            selected: false,
            mini: true));
  }

  buildPrevMonthDay(int day) {
    final year = getYear(currMonth - 1);
    final month = getMonth(currMonth - 1);
    final isEnable =
        isEnabledDay(year, month, day) && !isDisabledDay(year, month, day);

    return Center(
        child: Day(
            day: day,
            useUnselectedEffect: true,
            dayEvents: eventSelector.getEventsByDayMonthYear(
                EventDateTime(year: year, month: month, day: day)),
            weekDay: '',
            enabled: isEnable,
            onCalendarChanged: () {
              // reset to first to fix switching between 31/30/29 month lengths
              calendarSelector.goToDay(1);
              calendarSelector.previousMonth();
              calendarSelector.goToDay(day);
              widget.onCalendarChanged.call();
            },
            selected: false,
            mini: true));
  }
}
