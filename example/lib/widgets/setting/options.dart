import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/models/expanded_item_model.dart';
import 'package:flutter_event_calendar_example/widgets/setting/item_setting.dart';

import 'package:flutter_event_calendar_example/widgets/color/calendar_color_item.dart';
import 'package:flutter_event_calendar_example/widgets/setting/radio_button_list.dart';
import 'package:flutter_event_calendar/src/widgets/select_month.dart';
import 'package:flutter_event_calendar/src/widgets/select_year.dart';
import 'package:flutter_event_calendar/src/widgets/select_day.dart';
import 'package:flutter_event_calendar/src/models/style/select_month_options.dart';
import 'package:flutter_event_calendar/src/models/style/select_year_options.dart';
import 'package:flutter_event_calendar/src/models/style/day_options.dart';
import 'package:flutter_event_calendar/src/models/calendar_options.dart';

class Options extends StatefulWidget {
  Options({Key? key, this.onMonthChanged, this.onYearChanged})
      : super(key: key);
  CalendarChangeCallback? onMonthChanged;
  CalendarChangeCallback? onYearChanged;
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

class SelectDatePicker extends StatelessWidget {
  SelectDatePicker(
      {Key? key, required this.onMonthChanged, required this.onYearChanged})
      : super(key: key);
  Function onMonthChanged;
  Function onYearChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext mmm) {
                      return SelectDay(
                        onHeaderChanged: onYearChanged,
                        yearStyle: YearOptions(
                          // font: CalendarOptions.of(context).font,
                          selectedColor: Colors.blue,
                        ),
                      );
                    },
                  );
                },
                child: Text("day")),
            TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext mmm) {
                      return SelectMonth(
                        onHeaderChanged: onMonthChanged,
                        monthStyle: MonthOptions(
                          //  font: CalendarOptions.of(context).font,
                          selectedColor: Colors.blue,
                        ),
                      );
                    },
                  );
                },
                child: Text("month")),
            TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext mmm) {
                      return SelectYear(
                        onHeaderChanged: onYearChanged,
                        yearStyle: YearOptions(
                          // font: CalendarOptions.of(context).font,
                          selectedColor: Colors.blue,
                        ),
                      );
                    },
                  );
                },
                child: Text("year")),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: TextButton(
              onPressed: () {},
              child: Text("Add"),
            ))
          ],
        )
      ],
    );
  }
}
