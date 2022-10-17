import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/models/expanded_item_model.dart';
import 'package:flutter_event_calendar_example/widgets/color/color_picker_row.dart';
import 'package:flutter_event_calendar_example/widgets/setting/item_setting.dart';
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
  late List<String> fontList;
  late List<String> toggleViewTypeList;
  late List<String> viewTypeList;
  CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
  late List<ExpandedItemModel> settingItemsCalendarOptions;
  @override
  void initState() {
    streamController = getit<StreamController<CalendarEventModel>>();
    fontList = ['Dancing', 'IRanSans', 'Default'];
    toggleViewTypeList = ['true', 'false'];
    viewTypeList = ['DAILY', 'MONTHLY'];
    settingItemsCalendarOptions = [
      ExpandedItemModel(
          icon: 'assets/language_icon.svg',
          title: "View Type",
          body: RadioButtonList(
            initValue: calendarEventModel.calendarOptions.viewType.name,
            listItems: viewTypeList,
            onChanged: (keyName) {
              calendarEventModel.calendarOptions.viewType = ViewType.values
                  .firstWhere((element) => element.name == keyName);
              streamController.sink.add(calendarEventModel);
            },
          ),
          definition:
              "View Type:Change the Calendar view type to Daily or Monthly "),
      ExpandedItemModel(
          icon: 'assets/calendar.svg',
          title: "ToggleView Type",
          body: RadioButtonList(
              initValue:
                  calendarEventModel.calendarOptions.toggleViewType.toString(),
              listItems: toggleViewTypeList,
              onChanged: (keyName) {
                calendarEventModel.calendarOptions.toggleViewType =
                    keyName.toLowerCase() == 'true';
                streamController.sink.add(calendarEventModel);
              }),
          definition:
              "ToggleView:It adds an icon that clicking on it helps to switch between Monthly and Daily"),
      ExpandedItemModel(
          icon: 'assets/calendar.svg',
          title: "Font",
          body: RadioButtonList(
              initValue: calendarEventModel.calendarOptions.font == ''
                  ? 'Default'
                  : calendarEventModel.calendarOptions.font,
              listItems: fontList,
              onChanged: (keyName) {
                calendarEventModel.calendarOptions.font = keyName;
                streamController.sink.add(calendarEventModel);
              }),
          definition: "Font: permits calendar font customization."),
      ExpandedItemModel(
          icon: 'assets/color_filter.svg',
          title: 'Calendar Color',
          body: ColorPickerRow(
              title: "background",
              currentColor:
                  calendarEventModel.calendarOptions.headerMonthBackColor,
              onChanged: (colorSelected) {
                calendarEventModel.calendarOptions.headerMonthBackColor =
                    colorSelected;
                streamController.sink.add(calendarEventModel);
              }),
          definition: "Calendar Color: The color of the Calendar's background")
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ItemSetting(
        title: "Calendar Options",
        expandeditemModelList: settingItemsCalendarOptions);
  }
}
