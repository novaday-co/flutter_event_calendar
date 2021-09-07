import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/Event.dart';
import 'package:flutter_event_calendar/src/providers/calendares/calendar_provider.dart';
import 'package:flutter_event_calendar/src/providers/instance_provider.dart';
import 'package:flutter_event_calendar/src/utils/types/calendar_types.dart';
import 'package:flutter_event_calendar/src/widgets/CalendarDaily.dart';
import 'package:flutter_event_calendar/src/widgets/CalendarMonthly.dart';
import 'package:flutter_event_calendar/src/widgets/Events.dart';
import 'package:flutter_event_calendar/src/widgets/Header.dart';
export 'package:flutter_event_calendar/src/handlers/Event.dart';

class EventCalendar extends StatefulWidget {
  static late CalendarProvider calendarProvider;

  static late String dateTime;
  static late List<Event> events;
  static List<Event> selectedEvents = [];
  static late String font;
  static late HeaderMonthStringTypes headerMonthStringType;
  static late HeaderWeekDayStringTypes headerWeekDayStringType;
  static late DayEventCountViewType dayEventCountViewType;
  static late Color weekDaySelectedColor;
  static late Color weekDayUnselectedColor;
  static late Color dayIndexSelectedBackgroundColor;
  static late Color dayIndexUnselectedBackgroundColor;
  static late Color dayIndexSelectedForegroundColor;
  static late Color dayIndexUnelectedForegroundColor;
  static late Color dayEventCountColor;
  static late Color dayEventCountTextColor;
  static late String emptyText;
  static late Color emptyTextColor;
  static late IconData emptyIcon;
  static late Color emptyIconColor;
  static late Color eventBackgroundColor;
  static late Color eventTitleColor;
  static late Color eventDescriptionColor;
  static late Color eventDateTimeColor;
  static late CalendarViewType viewType;

  static late String locale;

  static bool canSelectViewType = false;

  EventCalendar(
      {CalendarType? type,
      List<Event>? events,
      required bool canSelectViewType,
      dateTime,
      font,
      HeaderMonthStringTypes? headerMonthStringType,
      HeaderWeekDayStringTypes? headerWeekDayStringType,
      weekDaySelectedColor,
      weekDayUnselectedColor,
      dayIndexSelectedBackgroundColor,
      dayIndexUnselectedBackgroundColor,
      dayIndexSelectedForegroundColor,
      dayIndexUnelectedForegroundColor,
      dayEventCountColor,
      dayEventCountViewType,
      dayEventCountTextColor,
      emptyText,
      emptyTextColor,
      emptyIcon,
      emptyIconColor,
      eventBackgroundColor,
      eventTitleColor,
      eventDescriptionColor,
      eventDateTimeColor,
      viewType,
      // isRTL,
      required String locale}) {
    calendarProvider = createInstance(locale);

    // EventCalendar.type = calendarProvider.typ;
    EventCalendar.events = events ?? [];
    EventCalendar.headerMonthStringType =
        headerMonthStringType ?? HeaderMonthStringTypes.Full;
    EventCalendar.headerWeekDayStringType =
        headerWeekDayStringType ?? HeaderWeekDayStringTypes.Short;
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
    EventCalendar.dayEventCountColor = dayEventCountColor ?? Colors.orange;
    EventCalendar.dayEventCountTextColor =
        dayEventCountTextColor ?? Colors.white;
    EventCalendar.dayEventCountViewType =
        dayEventCountViewType ?? DayEventCountViewType.LABEL;
    EventCalendar.font = font ?? '';
    EventCalendar.locale = locale;
    EventCalendar.dateTime = dateTime ?? calendarProvider.getDateTime();
    EventCalendar.viewType = viewType ?? CalendarViewType.Monthly;
    EventCalendar.canSelectViewType = canSelectViewType;
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
            isMonthlyView()
                ? CalendarMonthly(onCalendarChanged: () {
                    setState(() {});
                  })
                : CalendarDaily(
                    onCalendarChanged: () {
                      setState(() {});
                    },
                  ),
            Events(onEventsChanged: () {
              setState(() {});
            }),
          ],
        ),
      ),
    );
  }

  isMonthlyView() {
    return EventCalendar.viewType == CalendarViewType.Monthly;
  }
}
