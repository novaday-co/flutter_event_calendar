import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import '../../injection.dart';
class EventCalendarPage extends StatefulWidget {
  const EventCalendarPage({Key? key}) : super(key: key);

  @override
  State<EventCalendarPage> createState() => _EventCalendarPageState();
}

class _EventCalendarPageState extends State<EventCalendarPage> {
  StreamController<CalendarEventModel> streamController =
  getit<StreamController<CalendarEventModel>>();
  late Stream stream;
  late StreamSubscription<CalendarEventModel> streamSubscription;
  CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
  @override
  void initState() {
    streamController.stream.listen((event) {
      //setState(() {
        calendarEventModel = event;
    //  });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  EventCalendar(
      specialDays:calendarEventModel.specialDays,
      showLoadingForEvent: true,
      calendarType: calendarEventModel.calendarType,
      calendarLanguage: calendarEventModel.calendarLanguage,
      calendarOptions: CalendarOptions(
          viewType: calendarEventModel.calendarOptions.viewType,
          headerMonthBackColor:
          calendarEventModel.calendarOptions.headerMonthBackColor,
          toggleViewType:
          calendarEventModel.calendarOptions.toggleViewType,
          font: calendarEventModel.calendarOptions.font),
      dayOptions: DayOptions(
          selectedBackgroundColor:
          calendarEventModel.dayOptions.selectedBackgroundColor),
      headerOptions: HeaderOptions(
        headerTextColor: calendarEventModel.headerOptions.headerTextColor,
        navigationColor: calendarEventModel.headerOptions.navigationColor,
        monthStringType: calendarEventModel.headerOptions.monthStringType,
        weekDayStringType:
        calendarEventModel.headerOptions.weekDayStringType,
      ),
    );
  }
}
