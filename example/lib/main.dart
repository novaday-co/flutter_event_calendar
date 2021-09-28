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
    var text = "text";
    // than having to individually change instances of widgets.
    return Scaffold(
      body: EventCalendar(
        calendarType: CalendarType.Jalali,
        calendarLanguage: 'fa',
        canSelectViewType: true,
        headersStyle: HeadersStyle(monthStringType: MonthStringTypes.Full),
        onChangeDateTime: (dateTime) {
          print("$dateTime");
        },
        middleWidget: (dateTime){
          return Container(
            color: Colors.blueGrey,
            height: 75,
            child: Center(child: Text("Program what you think ${dateTime.toString()}",style: TextStyle(color: Colors.white,fontSize: 18),),),
          );
        },
        events: [
          Event(
            title: 'Laravel Event',
            description:
                'The largest Laravel event of the year, streamed directly to you. We’ve put together a full day of talks featuring some of Laravel’s brightest minds, and streaming them directly to your home or office.',
            dateTime: EventDateTime(year: 1400, month: 07, day: 22),
          ),

          Event(
            title: 'Vue.js Event',
            description:
                'Friday 18th September exclusive news from Evan You Live on our Youtube channel.' +
                    'This is FREE to the whole community & part of the #vuejsglobal conference experience.' +
                    'Subscribe Today to set up your notification.',
            dateTime: EventDateTime(year: 1400, month: 07, day: 24),
          ),
        ],
      ),
    );
  }
}
