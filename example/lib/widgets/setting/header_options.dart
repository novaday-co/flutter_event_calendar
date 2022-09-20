import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/models/expanded_item_model.dart';
import 'package:flutter_event_calendar_example/widgets/color/color_picker_row.dart';
import 'package:flutter_event_calendar_example/widgets/setting/item_setting.dart';
import 'package:flutter_event_calendar_example/widgets/setting/radio_button_list.dart';

class HeaderOptions extends StatefulWidget {
  HeaderOptions({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderOptions> createState() => _HeaderOptionsState();
}

class _HeaderOptionsState extends State<HeaderOptions> {
  late StreamController streamController;

  CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
  List<String> calendarMonthTypeList = [
    MonthStringTypes.SHORT.name,
    MonthStringTypes.FULL.name
  ];
  List<String> calendarWeekDayTypeList = [
    WeekDayStringTypes.SHORT.name,
    WeekDayStringTypes.FULL.name
  ];
  @override
  void initState() {
    streamController = getit<StreamController<CalendarEventModel>>();
    streamController.stream.listen((event) {
    //  setState(() {
       calendarEventModel = event;
    //  });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    List<ExpandedItemModel> settingItemsHeaderOptions = [
      ExpandedItemModel(
          icon: 'assets/calendar.svg',
          title: "WeekDay Type",
          body: RadioButtonList(
              initValue:
                  calendarEventModel.headerOptions.weekDayStringType.name,
              listItems: calendarWeekDayTypeList,
              onChanged: (dynamic keyName) {
                calendarEventModel.headerOptions.weekDayStringType =
                    WeekDayStringTypes.values
                        .firstWhere((element) => element.name == keyName);
                streamController.sink.add(calendarEventModel);
                setState(() {
                });
              }),
          definition: "WeekDayType:abbreviate days of the week"),
      ExpandedItemModel(
          icon: 'assets/calendar.svg',
          title: "Month Type",
          body: RadioButtonList(
              initValue: calendarEventModel.headerOptions.monthStringType.name,
              listItems: calendarMonthTypeList,
              onChanged: (dynamic keyName) {
                calendarEventModel.headerOptions.monthStringType =
                    MonthStringTypes.values
                        .firstWhere((element) => element.name == keyName);
                streamController.sink.add(calendarEventModel);
                setState(() {
                });
              }),
          definition: "Monthtype:abbreviate months of the year"),
      ExpandedItemModel(
          icon: 'assets/calendar.svg',
          title: "navigationColor",
          body: ColorPickerRow(
              title: "navigation",
              currentColor: calendarEventModel.headerOptions.navigationColor,
              onChanged: (dynamic colorSelected) {
                calendarEventModel.headerOptions.navigationColor =
                    colorSelected;
                streamController.sink.add(calendarEventModel);
                setState(() {
                });
              }),
          definition: "navigationColor:The color of Header navigation icons"),
      ExpandedItemModel(
          icon: 'assets/calendar.svg',
          title: "headerTextColor",
          body: ColorPickerRow(
              title: "headerText",
              currentColor: calendarEventModel.headerOptions.headerTextColor,
              onChanged: (dynamic colorSelected) {
                calendarEventModel.headerOptions.headerTextColor =
                    colorSelected;
                streamController.sink.add(calendarEventModel);
                setState(() {
                });
              }),
          definition: "headerTextColor:The color of Header Text"),
    ];

    return itemSetting(
      title: "Header Options",
      expandeditemModelList: settingItemsHeaderOptions,
    );
  }
}
