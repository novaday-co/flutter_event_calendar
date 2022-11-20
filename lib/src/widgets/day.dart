import 'dart:math';

import 'package:flutter/material.dart';

import '../../flutter_event_calendar.dart';

class Day extends StatelessWidget {
  String weekDay;
  Function? onCalendarChanged;
  List<Event> dayEvents;
  int day;
  DayOptions? dayOptions;
  CalendarOptions? calendarOptions;
  DayStyle? dayStyle;
  late double opacity;

  Day(
      {required this.day,
      required this.weekDay,
      required this.dayEvents,
      this.dayOptions,
      this.dayStyle,
      this.onCalendarChanged,
      this.calendarOptions})
      : super() {
    dayOptions ??= DayOptions();
    dayStyle ??= const DayStyle();
    calendarOptions ??= CalendarOptions();
  }

  late Widget child;

  late Color textColor;

  @override
  Widget build(BuildContext context) {
    dayOptions = DayOptions.of(context);
    calendarOptions = CalendarOptions.of(context);
    opacity = _shouldHaveTransparentColor() ? 0.5 : 1;

    textColor = dayStyle!.useDisabledEffect
        ? dayOptions!.disabledTextColor
        : dayStyle!.selected
            ? dayOptions!.selectedTextColor
            : dayOptions!.unselectedTextColor;

    child = InkWell(
      onTap: (() {
        if (dayStyle!.enabled) onCalendarChanged?.call();
      }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (DayOptions.of(context).showWeekDay &&
              CalendarOptions.of(context).viewType == ViewType.DAILY) ...[
            FittedBox(
              child: Text(
                '$weekDay',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _getTitleColor(),
                  fontFamily: CalendarOptions.of(context).font,
                ),
              ),
            ),
          ],
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
            padding: dayStyle!.compactMode
                ? EdgeInsets.zero
                : (EdgeInsets.all(HeaderOptions.of(context).weekDayStringType ==
                        WeekDayStringTypes.FULL
                    ? 4
                    : 0)),
            decoration: BoxDecoration(
                color: dayStyle!.selected
                    ? dayOptions!.selectedBackgroundColor
                    : dayOptions!.unselectedBackgroundColor,
                shape: BoxShape.circle),
            constraints: BoxConstraints(
                minWidth: double.infinity, minHeight: dayStyle!.compactMode ? 35 : 40),
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
                dayOptions!.eventCounterViewType == DayEventCounterViewType.DOT
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: dotMaker(context),
                      )
                    : Positioned(
                        right: 0,
                        bottom: 0,
                        child: labelMaker(context),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
    // }
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: EdgeInsets.all(dayStyle!.compactMode ? 0 : CalendarOptions.of(context).viewType==ViewType.DAILY?10:0),
        decoration: dayStyle?.decoration,
        width: dayStyle!.compactMode
            ? 45
            : (HeaderOptions.of(context).weekDayStringType ==
                    WeekDayStringTypes.FULL
                ? 80
                : 60),
        child: child,
      ),
    );
  }

  dotMaker(BuildContext context) {
    List<Widget> widgets = [];

    final maxDot = min(dayEvents.length, 3);
    for (int i = 0; i < maxDot; i++) {
      widgets.add(
        Container(
          margin: EdgeInsets.only(
              bottom: HeaderOptions.of(context).weekDayStringType ==
                      WeekDayStringTypes.SHORT
                  ? (dayStyle!.compactMode ? 4 : 8)
                  : 4),
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: dayOptions!.eventCounterColor,
          ),
        ),
      );
      if (i != maxDot - 1) {
        widgets.add(
          const SizedBox(
            width: 2,
          ),
        );
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widgets,
    );
  }

  labelMaker(BuildContext context) {
    if (dayEvents.isEmpty) return Container();
    return Container(
      width: dayStyle!.compactMode ? 15 : 18,
      height: dayStyle!.compactMode ? 15 : 18,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: dayOptions!.eventCounterColor,
      ),
      child: Text(
        "${dayEvents.length >= 10 ? '+9' : dayEvents.length}",
        style: TextStyle(
            fontSize: 12,
            fontFamily: CalendarOptions.of(context).font,
            color: dayStyle!.useUnselectedEffect
                ? dayOptions!.eventCounterTextColor.withOpacity(opacity)
                : dayOptions!.eventCounterTextColor),
      ),
    );
  }

  _getTitleColor() {
    return dayStyle!.selected ? dayOptions!.weekDaySelectedColor : dayOptions!.weekDayUnselectedColor;
  }

  _shouldHaveTransparentColor() {
    return !dayStyle!.enabled || dayStyle!.useUnselectedEffect;
  }
}

class DayStyle {
  final bool compactMode;
  final bool useUnselectedEffect;
  final bool enabled;
  final bool selected;
  final bool useDisabledEffect;
  final BoxDecoration? decoration;

  const DayStyle({
    this.compactMode = false,
    this.useUnselectedEffect = false,
    this.enabled = false,
    this.selected = false,
    this.decoration = const BoxDecoration(),
    this.useDisabledEffect = false,
  });
}
