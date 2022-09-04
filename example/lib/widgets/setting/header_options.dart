import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/models/expanded_item_model.dart';
import 'package:flutter_event_calendar_example/widgets/setting/item_setting.dart';
import 'package:flutter_event_calendar_example/widgets/setting/radio_button_list.dart';


class HeaderOptions extends StatefulWidget {
  HeaderOptions({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderOptions> createState() =>
      _HeaderOptionsState();
}

class _HeaderOptionsState
    extends State<HeaderOptions> {
  late StreamController streamController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> calendarMonthTypeList = [
      MonthStringTypes.SHORT.name,
      MonthStringTypes.FULL.name
    ];
    List<String> calendarWeekDayTypeList = [
      WeekDayStringTypes.SHORT.name,
      WeekDayStringTypes.FULL.name
    ];

    streamController = getit<StreamController<CalendarEventModel>>();
    CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
    List<ExpandedItemModel> settingItemsHeaderOptions = [
      ExpandedItemModel(
        icon: 'assets/calendar.svg',
        title: "WeekDay Type",
        body: RadioButtonList(
            initValue: calendarEventModel.headerOptions.weekDayStringType.name,
            listItems: calendarWeekDayTypeList,
            onChanged: (dynamic keyName) {
              calendarEventModel.headerOptions.weekDayStringType =
                  WeekDayStringTypes.values
                      .firstWhere((element) => element.name == keyName);
              streamController.sink.add(calendarEventModel);
            }),
        definition: "WeekDay Option formats abbreviated the days "
      ),
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
            }),
        definition: "Month Type Option formats abbreviated the months"
      ),

    ];

    return itemSetting(title:"Header Options",expandeditemModelList: settingItemsHeaderOptions,);
  }
}


