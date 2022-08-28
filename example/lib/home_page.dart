import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/setting.dart';

import 'injection.dart';
import 'models/calender_setting_item_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String calendarLanguage = "en";

  var streamSubscription = getit<StreamController<CalendarEventModel>>().stream;

  CalendarEventModel calendarEventModel = getit<CalendarEventModel>();

  @override
  void initState() {
    streamSubscription.listen((event) {
      setState(() {
        calendarEventModel = event;
        print("event is" + event.toString());
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarSetting()),
                );
              },
              icon: Icon(Icons.settings),
            ),
          ),
          Icon(Icons.add)
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Expanded(
            child: EventCalendar(
              showLoadingForEvent: true,
              calendarType: calendarEventModel.calendarType,
              calendarLanguage: calendarEventModel.calendarLanguage ?? "fa",
              //  calendarOptions: CalendarOptions(toggleViewType:calendarEventModel.calendarOptions.toggleViewType),
              headerOptions: HeaderOptions(
                  monthStringType:
                      calendarEventModel.headerOptions.monthStringType ??
                          MonthStringTypes.SHORT),
            ),
          ),
        ]),
      ),
    );
  }
}
