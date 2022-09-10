import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/widgets/event_calendar/home_page.dart';
import 'package:flutter_event_calendar_example/widgets/setting/setting.dart';
import 'injection.dart';

void main() {
  setUp();
  final list1 = <int>[1, 2, 3, 4];
  final list2 = <int>[5, 6, 7, 8, 9];
// Copies the 4th and 5th items in list2 as the 2nd and 3rd items
// of list1.
  const skipCount = 3;
  list1.setRange(1, 3, list2, 3);
  print(list1.getRange(0, list1.length)); // [1, 8, 9, 4]
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
