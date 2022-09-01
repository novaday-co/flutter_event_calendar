import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/setting.dart';
import 'package:flutter_event_calendar_example/widgets/code_preview.dart';
import 'injection.dart';
import 'package:hive/hive.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<CalendarEventModel> streamController=getit<StreamController<CalendarEventModel>>();
  late Stream stream;
  late StreamSubscription<CalendarEventModel> streamSubscription;
  CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
  @override
  void initState() {

   streamController.stream.listen((event) {
     print("listened");
     setState(() {
       calendarEventModel=event;
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
          bottom:TabBar(tabs: [
            Tab(text: "preview",icon: Icon(Icons.calendar_month),),
            Tab(text:"code",icon: Icon(Icons.code)),
            Tab(text:"setting",icon: Icon(Icons.settings))
          ],) ,
        ),
        body: TabBarView(
        children: [
            EventCalendar(
              showLoadingForEvent: true,
              calendarType: calendarEventModel.calendarType,
              calendarLanguage: calendarEventModel.calendarLanguage ,
              calendarOptions: CalendarOptions(headerMonthBackColor: calendarEventModel.calendarOptions.headerMonthBackColor,),
              dayOptions: DayOptions(selectedBackgroundColor:calendarEventModel.dayOptions.selectedBackgroundColor),
              headerOptions: HeaderOptions(
                  monthStringType:
                     calendarEventModel.headerOptions.monthStringType),
            ),
          CodePreview(),
          CalendarSetting()
          ]
        ),
      ),
    );
  }
  @override
  void dispose() {
     streamController.close();
    super.dispose();
  }
}
