import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/models/calendar_options.dart';
import 'package:flutter_event_calendar/src/models/event.dart';
import 'package:flutter_event_calendar/src/models/style/headers_style.dart';
import 'package:flutter_event_calendar/src/models/style/event_style.dart';
import 'package:flutter_event_calendar/src/providers/calendars/calendar_provider.dart';
import 'package:flutter_event_calendar/src/providers/instance_provider.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';
import 'package:flutter_event_calendar/src/widgets/calendar_daily.dart';
import 'package:flutter_event_calendar/src/widgets/calendar_monthly.dart';
import 'package:flutter_event_calendar/src/widgets/events.dart';
import 'package:flutter_event_calendar/src/widgets/header.dart';
import 'package:scoped_model/scoped_model.dart';

typedef CalendarChangeCallback = Function(EventDateTime);

class EventCalendar extends StatefulWidget {
  static late CalendarProvider calendarProvider;
  static late EventDateTime dateTime;
  static late List<Event> events;
  static List<Event> selectedEvents = [];

  // static late HeaderMonthStringTypes headerMonthStringType;
  // static late HeaderWeekDayStringTypes headerWeekDayStringType;
  static late String calendarLanguage;
  static late CalendarType calendarType;

  CalendarChangeCallback? onChangeDateTime;

  List<EventDateTime> disabledDays;

  List<EventDateTime> enabledDays;

  List<EventDateTime> colorizedDays;

  CalendarOptions? calendarOptions;

  DayStyle? dayStyle;

  EventStyle? eventStyle;

  HeadersStyle? headersStyle;

  EventCalendar(
      {List<Event>? events,
      canSelectViewType,
      EventDateTime? dateTime,
      this.calendarOptions,
      this.dayStyle,
      this.eventStyle,
      this.headersStyle,
      this.enabledDays = const [],
      this.disabledDays = const [],
      this.colorizedDays = const [],
      this.onChangeDateTime,
      required calendarType,
      calendarLanguage}) {
    calendarProvider = createInstance(calendarType);

    if (this.calendarOptions == null) this.calendarOptions = CalendarOptions();
    if (this.eventStyle == null) this.eventStyle = EventStyle();
    if (this.dayStyle == null) this.dayStyle = DayStyle();

    EventCalendar.events = events ?? [];
    EventCalendar.dateTime = dateTime ?? calendarProvider.getDateTime();
    EventCalendar.calendarType = calendarType ?? CalendarType.Gregorian;
    EventCalendar.calendarLanguage = calendarLanguage ?? 'en';
  }

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: buildScopeModels(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Header(
                onHeaderChanged: () {
                  widget.onChangeDateTime?.call(EventCalendar.dateTime);
                  setState(() {});
                },
              ),
              isMonthlyView()
                  ? CalendarMonthly(
                      disabledDays: widget.disabledDays,
                      enabledDays: widget.enabledDays,
                      colorizedDays: widget.colorizedDays,
                      onCalendarChanged: () {
                        widget.onChangeDateTime?.call(EventCalendar.dateTime);
                        setState(() {});
                      })
                  : CalendarDaily(
                      colorizedDays: widget.colorizedDays,
                      disabledDays: widget.disabledDays,
                      enabledDays: widget.enabledDays,
                      onCalendarChanged: () {
                        widget.onChangeDateTime?.call(EventCalendar.dateTime);
                        setState(() {});
                      }),
              Events(onEventsChanged: () {
                setState(() {});
              }),
            ],
          ),
        ),
      ),
    );
  }

  isMonthlyView() {
    return widget.calendarOptions?.viewType == ViewType.Monthly;
  }

  buildScopeModels({required Container child}) {
    return ScopedModel<CalendarOptions>(
      model: widget.calendarOptions!,
      child: ScopedModel<DayStyle>(
        model: widget.dayStyle!,
        child: ScopedModel<EventStyle>(
          model: widget.eventStyle!,
          child: ScopedModel<HeadersStyle>(
            model: widget.headersStyle!,
            child: child,
          ),
        ),
      ),
    );
  }
}
