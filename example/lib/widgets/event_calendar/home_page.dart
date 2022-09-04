import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/widgets/setting/setting.dart';
import 'package:flutter_event_calendar_example/widgets/code_preview/code_preview.dart';
import '../../injection.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<CalendarEventModel> streamController =
      getit<StreamController<CalendarEventModel>>();
  late Stream stream;
  late StreamSubscription<CalendarEventModel> streamSubscription;
  CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
  @override
  void initState() {
    streamController.stream.listen((event) {
      setState(() {
        calendarEventModel = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "preview",
                icon: Icon(Icons.calendar_month),
              ),
              Tab(text: "code", icon: Icon(Icons.code)),
              Tab(text: "setting", icon: Icon(Icons.settings))
            ],
          ),
        ),
        body: TabBarView(children: [
          EventCalendar(
            // events: [Event(child: Text("osmfosdf"), dateTime:     CalendarDateTime(year: 1401, month: 06, day: 1, calendarType: CalendarType.JALALI,
            //     isEnableDay: true),)],
            specialDays: [
              CalendarDateTime(
                  year: 1401,
                  month: 6,
                  day: 2,
                  calendarType: CalendarType.JALALI,
                  color: Colors.green),
              CalendarDateTime(
                  year: 1401,
                  month: 6,
                  day: 13,
                  calendarType: CalendarType.JALALI,
                  color: Colors.green)
            ],
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
          ),
          CodePreview(),
          Setting()
        ]),
      ),
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
