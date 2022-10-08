import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';


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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SafeArea(
        child: EventCalendar(
          selectedDaysRangeCallBack: (List<CalendarDateTime> selectedRange){
            print(selectedRange);
          },
          calendarType: CalendarType.GREGORIAN,
          calendarLanguage: 'fa',
          calendarOptions: CalendarOptions(viewType: ViewType.MONTHLY),
        ),
      ),
    );
  }
}