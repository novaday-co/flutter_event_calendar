import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/setting.dart';
import 'injection.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<CalendarEventModel> streamController=getit<StreamController<CalendarEventModel>>();
  Stream stream;
  StreamSubscription<CalendarEventModel> streamSubscription;
  CalendarEventModel calendarEventModel = getit<CalendarEventModel>();

  @override
  void initState() {
    stream=streamController.stream;
   stream.listen((event) {
     print("listened");
     setState(() {
       calendarEventModel=event;
     });
   });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
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
              calendarLanguage: calendarEventModel.calendarLanguage ,
              calendarOptions: CalendarOptions(headerMonthBackColor: calendarEventModel.calendarOptions.headerMonthBackColor,),
              dayOptions: DayOptions(selectedBackgroundColor:calendarEventModel.dayOptions.selectedBackgroundColor),
              headerOptions: HeaderOptions(
                  monthStringType:
                     calendarEventModel.headerOptions.monthStringType),
            ),
          ),
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
