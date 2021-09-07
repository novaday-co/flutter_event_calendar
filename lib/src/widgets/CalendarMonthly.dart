import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/handlers/Translator.dart';
import 'package:flutter_event_calendar/src/widgets/Day.dart';

class CalendarMonthly extends StatefulWidget {
  Function onCalendarChanged;

  CalendarMonthly({required this.onCalendarChanged, Key? key}) : super();

  @override
  State<CalendarMonthly> createState() => _CalendarMonthlyState();
}

class _CalendarMonthlyState extends State<CalendarMonthly> {
  List<String> dayNames = Translator().getDayNames();

  @override
  void didUpdateWidget(covariant CalendarMonthly oldWidget) {
    dayNames = Translator().getDayNames();
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
    final currentMonth = CalendarSelector()
        .getPart(format: PartFormat.month, responseType: 'int');

    final int firstDayIndex = getFirstDayOfMonth();
    final int lastDayIndex = firstDayIndex + getLastDayOfMonth();
    final lastMonthLastDay = getLastMonthLastDay();
    final int cDayIndex =
        CalendarSelector().getPart(format: PartFormat.day, responseType: 'int');

    return SizedBox(
      height: 260,
      child: Directionality(
        textDirection: EventCalendar.calendarProvider.isRTL()
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 42,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) => _buildItem(index, firstDayIndex,
                lastDayIndex, lastMonthLastDay, currentMonth, cDayIndex)),
      ),
    );
  }

  _buildItem(int index, int firstDayIndex, int lastDayIndex,
      int lastMonthLastDay, int currentMonth, int cDayIndex) {
    int dayIndex = -1;

    final isCurrentMonthDays = index >= firstDayIndex && index < lastDayIndex;
    final isNextMonthDays = index >= lastDayIndex;

    if (isCurrentMonthDays)
      dayIndex = index - firstDayIndex + 1;
    else if (isNextMonthDays)
      dayIndex = index - lastDayIndex + 1;
    else
      dayIndex = lastMonthLastDay - (firstDayIndex - index) + 1;

    if (isCurrentMonthDays)
      return Center(
        child: Day(
          month: getMonth(currentMonth),
          year: getYear(currentMonth),
          dayIndex: dayIndex,
          weekDay: '',
          selected: dayIndex == cDayIndex,
          onCalendarChanged: () {
            CalendarSelector().goToDay(dayIndex);
            widget.onCalendarChanged.call();
          },
          mini: true,
        ),
      );
    else if (isNextMonthDays)
      return Center(
          child: Day(
              dayIndex: dayIndex,
              useUnselectedEffect: true,
              weekDay: '',
              month: getMonth(currentMonth + 1),
              year: getYear(currentMonth + 1),
              onCalendarChanged: () {
                CalendarSelector().nextMonth();
                CalendarSelector().goToDay(dayIndex);
                widget.onCalendarChanged.call();
              },
              selected: false,
              mini: true));
    else if (dayIndex > 0) {
      return Center(
          child: Day(
              dayIndex: dayIndex,
              useUnselectedEffect: true,
              month: getMonth(currentMonth - 1),
              year: getYear(currentMonth - 1),
              weekDay: '',
              onCalendarChanged: () {
                CalendarSelector().previousMonth();
                CalendarSelector().goToDay(dayIndex);
                widget.onCalendarChanged.call();
              },
              selected: false,
              mini: true));
    }
    return SizedBox();
  }

  int getFirstDayOfMonth() {
    final currentMonth = CalendarSelector()
        .getPart(format: PartFormat.month, responseType: 'int');
    final monthDays = CalendarSelector().getDays(currentMonth);
    print("${monthDays[1]}");
    print("${dayNames}");
    return dayNames.indexOf(monthDays[1]);
  }

  int getLastDayOfMonth() {
    final currentMonth = CalendarSelector()
        .getPart(format: PartFormat.month, responseType: 'int');
    return CalendarSelector().getDays(currentMonth).keys.last;
  }

  int getLastMonthLastDay() {
    final cMonth = CalendarSelector()
        .getPart(format: PartFormat.month, responseType: 'int');
    if (cMonth - 1 < 1) {
      return -1;
    }
    return CalendarSelector().getDays(cMonth - 1).keys.last;
  }

  getMonth(int month) {
    if (month > 12)
      return 1;
    else if (month < 1) return 1;
    return month;
  }

  getYear(int month) {
    final year = CalendarSelector()
        .getPart(format: PartFormat.year, responseType: 'int');
    if (month > 12)
      return year + 1;
    else if (month < 1) return year - 1;
    return year;
  }
}
