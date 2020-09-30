import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/Event.dart';
import 'package:flutter_event_calendar/src/widgets/Calendar.dart';
import 'package:flutter_event_calendar/src/widgets/Events.dart';
import 'package:flutter_event_calendar/src/widgets/Header.dart';
export 'package:flutter_event_calendar/src/handlers/Event.dart';
import 'package:shamsi_date/shamsi_date.dart';

class EventCalendar extends StatefulWidget {
  static String type = 'gregorian';
  static String dateTime;
  static List<Event> events;
  static List<Event> selectedEvents = [];
  static String font;
  static String headerMonthStringType;
  static String headerWeekDayStringType;
  static Color weekDaySelectedColor;
  static Color weekDayUnselectedColor;
  static Color dayIndexSelectedBackgroundColor;
  static Color dayIndexUnselectedBackgroundColor;
  static Color dayIndexSelectedForegroundColor;
  static Color dayIndexUnelectedForegroundColor;
  static String emptyText;
  static Color emptyTextColor;
  static IconData emptyIcon;
  static Color emptyIconColor;
  static Color eventBackgroundColor;
  static Color eventTitleColor;
  static Color eventDescriptionColor;
  static Color eventDateTimeColor;
  static bool isRTL;
  static String locale;

  EventCalendar({
    type,
    events,
    dateTime,
    font,
    headerMonthStringType,
    headerWeekDayStringType,
    weekDaySelectedColor,
    weekDayUnselectedColor,
    dayIndexSelectedBackgroundColor,
    dayIndexUnselectedBackgroundColor,
    dayIndexSelectedForegroundColor,
    dayIndexUnelectedForegroundColor,
    emptyText,
    emptyTextColor,
    emptyIcon,
    emptyIconColor,
    eventBackgroundColor,
    eventTitleColor,
    eventDescriptionColor,
    eventDateTimeColor,
    isRTL,
  }) {
    EventCalendar.type = type ?? 'gregorian';
    EventCalendar.events = events ?? [];
    EventCalendar.headerMonthStringType = headerMonthStringType ?? 'full';
    EventCalendar.headerWeekDayStringType = headerWeekDayStringType ?? 'short';
    EventCalendar.weekDaySelectedColor =
        weekDaySelectedColor ?? Color(0xff3AC3E2);
    EventCalendar.weekDayUnselectedColor =
        weekDayUnselectedColor ?? Colors.black38;
    EventCalendar.dayIndexSelectedBackgroundColor =
        dayIndexSelectedBackgroundColor ?? Color(0xff3AC3E2);
    EventCalendar.dayIndexUnselectedBackgroundColor =
        dayIndexUnselectedBackgroundColor ?? Colors.transparent;
    EventCalendar.dayIndexSelectedForegroundColor =
        dayIndexSelectedForegroundColor ?? Colors.white;
    EventCalendar.dayIndexUnelectedForegroundColor =
        dayIndexUnelectedForegroundColor ?? Colors.black;
    EventCalendar.emptyText = emptyText ?? null;
    EventCalendar.emptyTextColor = emptyTextColor ?? Color(0xffe5e5e5);
    EventCalendar.emptyIcon = emptyIcon ?? Icons.reorder;
    EventCalendar.emptyIconColor = emptyIconColor ?? Color(0xffebebeb);
    EventCalendar.eventBackgroundColor = eventBackgroundColor ?? Colors.white;
    EventCalendar.eventTitleColor = eventTitleColor ?? Colors.black;
    EventCalendar.eventDescriptionColor = eventDescriptionColor ?? Colors.grey;
    EventCalendar.eventDateTimeColor = eventDateTimeColor ?? Colors.grey;
    EventCalendar.font = font ?? '';

    final f = Jalali.now().formatter;
    EventCalendar.dateTime = dateTime ??
        (EventCalendar.type == 'jalali'
            ? '${f.y}-${f.mm}-${f.dd}'
            : DateTime.now().toString());

    if (isRTL != null)
      EventCalendar.isRTL = isRTL;
    else
      EventCalendar.isRTL = EventCalendar.type == 'jalali' ? true : false;

    EventCalendar.locale = EventCalendar.type == 'jalali' ? 'fa' : 'en';
  }

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Header(
              onHeaderChanged: () {
                setState(() {});
              },
            ),
            Calendar(onCalendarChanged: () {
              setState(() {});
            }),
            Events(onEventsChanged: () {
              setState(() {});
            }),
          ],
        ),
      ),
    );
  }
}
