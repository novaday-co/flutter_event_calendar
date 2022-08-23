import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/setting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalendarSetting(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // than having to individually change instances of widgets.
    return Scaffold(
      body: EventCalendar(
        calendarType: CalendarType.JALALI,
        calendarLanguage: 'fa',
        calendarOptions: CalendarOptions(viewType: ViewType.MONTHLY),
      ),
    );
  }
}

