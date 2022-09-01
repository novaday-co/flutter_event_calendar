import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/models/expanded_item_model.dart';
import 'package:flutter_event_calendar_example/widgets/expanded_card_setting.dart';
import 'package:flutter_event_calendar_example/widgets/radio_button_list.dart';
import 'package:flutter_event_calendar_example/widgets/calendar_color_item.dart';
import 'package:flutter_svg/svg.dart';

class CalendarSetting extends StatefulWidget {
  CalendarSetting({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarSetting> createState() => _CalendarSettingState();
}

class _CalendarSettingState extends State<CalendarSetting> {
  late StreamController streamController;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> listLanguage = ['fa', 'en'];
    List<String> calendarTypeList = ['Jalali', 'GREGORIAN'];
    List<String> calendarMonthTypeList = ['short', 'full'];

    streamController = getit<StreamController<CalendarEventModel>>();
    CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
    List<ExpandedItemModel> settingItems = [
      // ExpandedItemModel(
      //   icon: 'assets/language_icon.svg',
      //   title: "calendarLanguage",
      //   body: RadioButtonList(
      //     initValue: calendarEventModel.calendarLanguage,
      //     listItems: listLanguage,
      //     onChanged: (dynamic keyName) {
      //       if (keyName == 'fa') {
      //         calendarEventModel.calendarLanguage = "fa";
      //         streamController.sink.add(calendarEventModel);
      //       } else {
      //         calendarEventModel.calendarLanguage = "en";
      //         print(calendarEventModel.props);
      //         streamController.sink.add(calendarEventModel);
      //       }
      //     },
      //   ),
      // ),
      ExpandedItemModel(
        icon: 'assets/language_icon.svg',
        title: "calendarType",
        body: RadioButtonList(
          initValue: calendarEventModel.calendarType.calendarTypeToString(calendarEventModel.calendarType),
          listItems: calendarTypeList,
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
      //ExpandedItemModel(
      //     icon: 'assets/calendar.svg',
      //     title: "Month String Types",
      //     body: RadioButtonList(
      //       initValue:"short" ,
      //       listItems: calendarMonthTypeList,
      //       onChanged: (dynamic keyName) {
      //         if (keyName == 'full') {
      //           calendarEventModel.headerOptions.monthStringType =
      //               MonthStringTypes.FULL;
      //           streamController.sink.add(calendarEventModel);
      //         } else {
      //           calendarEventModel.headerOptions.monthStringType =
      //               MonthStringTypes.SHORT;
      //           streamController.sink.add(calendarEventModel);
      //         }
      //       },
      //     ),
      // ),
      ExpandedItemModel(
        icon: 'assets/color_filter.svg',
        title: 'Calendar Color',
        body: ColorPickerList(),
      )
    ];

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
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
                  itemCount: settingItems.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: ExpandedWidget(
                          items: settingItems,
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


}
