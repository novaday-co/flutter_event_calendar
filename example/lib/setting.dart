import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/models/expanded_item_model.dart';
import 'package:flutter_event_calendar_example/widgets/expanded_card_setting.dart';
import 'package:flutter_event_calendar_example/widgets/radio_button_list.dart';
import 'package:flutter_event_calendar_example/widgets/calendar_color_item.dart';

class CalendarSetting extends StatefulWidget {
  CalendarSetting({
    Key key,
  }) : super(key: key);

  @override
  State<CalendarSetting> createState() => _CalendarSettingState();
}

class _CalendarSettingState extends State<CalendarSetting> {
  StreamController streamController;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> listLanguage = ['Persian', 'English'];
    List<String> listCalendartype = ['Jalali', 'Miladi'];
    List<String> listMonthStringType = ['full', 'short'];

    streamController = getit<StreamController<CalendarEventModel>>();
    CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
    List<ExpandedItemModel> calendarOptions = [
      ExpandedItemModel(
        icon: 'assets/language_icon.svg',
        title: "calendarLanguage",
        body: RadioButtonList(
          listItems: listLanguage,
          onChanged: (dynamic keyName) {
            if (keyName == 'Persian') {
              calendarEventModel.calendarLanguage = "fa";
              streamController.sink.add(calendarEventModel);
            } else {
              calendarEventModel.calendarLanguage = "en";
              print(calendarEventModel.props);
              streamController.sink.add(calendarEventModel);
            }
          },
        ),
      ),
      ExpandedItemModel(
        icon: 'assets/language_icon.svg',
        title: "calendarType",
        body: RadioButtonList(
          listItems: listCalendartype,
          onChanged: (dynamic keyName) {
            if (keyName == 'Jalali') {
              calendarEventModel.calendarType = CalendarType.JALALI;
              streamController.sink.add(calendarEventModel);
            } else {
              calendarEventModel.calendarType = CalendarType.GREGORIAN;
              streamController.sink.add(calendarEventModel);
            }
          },
        ),
      ),
      ExpandedItemModel(
          icon: 'assets/calendar.svg',
          title: "Month String Types",
          body: RadioButtonList(
            listItems: listMonthStringType,
            onChanged: (dynamic keyName) {
              if (keyName == 'full') {
                calendarEventModel.headerOptions.monthStringType =
                    MonthStringTypes.FULL;
                streamController.sink.add(calendarEventModel);
              } else {
                calendarEventModel.headerOptions.monthStringType =
                    MonthStringTypes.SHORT;
                streamController.sink.add(calendarEventModel);
              }
            },
          )),
      ExpandedItemModel(
        icon: 'assets/color_filter.svg',
        title: 'Calendar Color',
        body: Container(
          child: Column(
            children: [CalendarColorItem()],
          ),
        ),
      )
    ];

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xffF5F5F5),
        elevation: 0,
        //leading: SvgPicture.asset('assets/back.svg'),
        //title: Text("Calendar Settings",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                ListView.builder(
                  itemCount: calendarOptions.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: ExpandedWidget(
                          items: calendarOptions,
                          index: index,
                        ),);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
   // streamController.close();
    super.dispose();
  }
}
