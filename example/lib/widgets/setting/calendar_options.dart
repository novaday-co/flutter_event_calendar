import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/models/expanded_item_model.dart';
import 'package:flutter_event_calendar_example/widgets/setting/item_setting.dart';

import 'package:flutter_event_calendar_example/widgets/color/calendar_color_item.dart';
import 'package:flutter_event_calendar_example/widgets/setting/radio_button_list.dart';

class CalendarOptions extends StatefulWidget {
  CalendarOptions({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarOptions> createState() => _CalendarOptionsState();
}

class _CalendarOptionsState extends State<CalendarOptions> {
  late StreamController streamController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<String> fontList=['Dancing','IRanSans','Default'];

    List<String> toggleViewTypeList = ['true', 'false'];
    List<String> viewTypeList = ['DAILY', 'MONTHLY'];
    streamController = getit<StreamController<CalendarEventModel>>();
    CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
    List<ExpandedItemModel> settingItemsCalendarOptions = [

      ExpandedItemModel(
          icon: 'assets/language_icon.svg',
          title: "View Type",
          body: RadioButtonList(
            initValue: calendarEventModel.calendarOptions.viewType.name,
            listItems: viewTypeList,
            onChanged: (dynamic keyName) {
              calendarEventModel.calendarOptions.viewType = ViewType.values
                  .firstWhere((element) => element.name == keyName);
              streamController.sink.add(calendarEventModel);
            },
          ),
          definition: "Calendar Type option helps you to switch between Gregoria Calendar and Solar Calendar"
      ),

      ExpandedItemModel(
        icon: 'assets/calendar.svg',
        title: "ToggleView Type",
        body: RadioButtonList(
            initValue:
            calendarEventModel.calendarOptions.toggleViewType.toString(),
            listItems: toggleViewTypeList,
            onChanged: (dynamic keyName) {
              calendarEventModel.calendarOptions.toggleViewType =
                  keyName.toLowerCase() == 'true';
              streamController.sink.add(calendarEventModel);
            }),
        definition: "Whether user can toggle view type between monthly and daily or not"
      ),
      ExpandedItemModel(
          icon: 'assets/calendar.svg',
          title: "Font",
          body: RadioButtonList(
              initValue:
              calendarEventModel.calendarOptions.font=='' ? 'Default': calendarEventModel.calendarOptions.font,
              listItems: fontList,
              onChanged: (dynamic keyName) {
                calendarEventModel.calendarOptions.font =keyName;
                streamController.sink.add(calendarEventModel);
              }),
          definition: "Font Option sets custom fonts to Calendar"
      ),
      ExpandedItemModel(
        icon: 'assets/color_filter.svg',
        title: 'Calendar Color',
        body: ColorPickerList(),
        definition: ""
      )

    ];

    return itemSetting(title: "Calendar Options",expandeditemModelList:settingItemsCalendarOptions);

  }
}
