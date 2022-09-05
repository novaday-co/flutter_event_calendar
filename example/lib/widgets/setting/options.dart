import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/models/expanded_item_model.dart';
import 'package:flutter_event_calendar_example/widgets/setting/data_picker.dart';
import 'package:flutter_event_calendar_example/widgets/setting/item_setting.dart';

import 'package:flutter_event_calendar_example/widgets/color/calendar_color_item.dart';
import 'package:flutter_event_calendar_example/widgets/setting/radio_button_list.dart';


class Options extends StatefulWidget {
  Options({Key? key, this.onMonthChanged, this.onYearChanged,this.onDayChanged})
      : super(key: key);
  CalendarChangeCallback? onMonthChanged;
  CalendarChangeCallback? onYearChanged;
  CalendarChangeCallback? onDayChanged;
  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  late StreamController streamController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    streamController = getit<StreamController<CalendarEventModel>>();
    CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
    List<String> calendarTypeList = [
      CalendarType.JALALI.name,
      CalendarType.GREGORIAN.name
    ];
    List<String> languageList = ['fa', 'en'];
    List<ExpandedItemModel> OptionsList = [
      ExpandedItemModel(
          icon: 'assets/language_icon.svg',
          title: "Special Days",
          body: SelectDatePicker(
            onDayChanged: () {
              widget.onDayChanged?.call(EventCalendar.dateTime!);
              setState(() {});
            },
            onYearChanged: () {
              widget.onMonthChanged?.call(EventCalendar.dateTime!);
              setState(() {});
            },
            onMonthChanged: () {
             widget.onMonthChanged?.call(EventCalendar.dateTime!);
             setState(() {});
            },
          ),
          definition: "SpecialDays: lets you set special days"),
      ExpandedItemModel(
          icon: 'assets/language_icon.svg',
          title: "Calendar Language",
          body: RadioButtonList(
            initValue: calendarEventModel.calendarLanguage,
            listItems: languageList,
            onChanged: (dynamic keyName) {
              calendarEventModel.calendarLanguage = keyName;
              streamController.sink.add(calendarEventModel);
            },
          ),
          definition:
              "CalendarLanguage: helps you to customize calendar's Language"),
      ExpandedItemModel(
          icon: 'assets/language_icon.svg',
          title: "Calendar Type",
          body: RadioButtonList(
            initValue: calendarEventModel.calendarType.name,
            listItems: calendarTypeList,
            onChanged: (dynamic keyName) {
              calendarEventModel.calendarType = CalendarType.values
                  .firstWhere((element) => element.name == keyName);
              streamController.sink.add(calendarEventModel);
            },
          ),
          definition:
              "CalendarType: helps you to switch between Gregoria Calendar and Solar Calendar"),
    ];

    return itemSetting(title: "Options", expandeditemModelList: OptionsList);
  }
}


