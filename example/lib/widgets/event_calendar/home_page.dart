import 'package:flutter/material.dart';
import 'package:flutter_event_calendar_example/widgets/event_calendar/eventCalendar.dart';
import 'package:flutter_event_calendar_example/widgets/setting/setting.dart';
import 'package:flutter_event_calendar_example/widgets/code_preview/code_preview.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Event Calendar"),
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
        body: TabBarView(
          physics: BouncingScrollPhysics(),
            children: [
          EventCalendarPage(),
          CodePreview(),
          Setting()
        ]),
      ),
    );
  }



}
