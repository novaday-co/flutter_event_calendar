import 'package:flutter/material.dart';
import 'package:flutter_event_calendar_example/widgets/setting/options.dart';

import 'calendar_options.dart';
import 'header_options.dart';

class Setting extends StatefulWidget {
  Setting({
    Key? key,
  }) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Options(),
                CalendarOptions(),
                HeaderOptions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
