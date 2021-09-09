import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
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
      body: EventCalendar(
        headerMonthStringType: HeaderMonthStringTypes.Full,
        headerWeekDayStringType: HeaderWeekDayStringTypes.Short,
        dayEventCountViewType: DayEventCountViewType.LABEL,
        dayEventCountTextColor: Colors.white,
        dayEventCountColor: Colors.blue,
        calendarType: CalendarType.Jalali,
        calendarLanguage: 'fa',
        viewType: CalendarViewType.Monthly,
        canSelectViewType: true,
        events: [
          Event(
            title: 'Laravel Event',
            description:
                'The largest Laravel event of the year, streamed directly to you. We’ve put together a full day of talks featuring some of Laravel’s brightest minds, and streaming them directly to your home or office.',
            dateTime: '1400-06-31 20:00',
          ),
          Event(
            title: 'Vue.js Event',
            description:
                'Friday 18th September exclusive news from Evan You Live on our Youtube channel.' +
                    'This is FREE to the whole community & part of the #vuejsglobal conference experience.' +
                    'Subscribe Today to set up your notification.',
            dateTime: '2021-08-31 20:00',
          ),
        ],
      ),
    );
  }
}
