import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/widgets/color/color_picker_row.dart';

class ColorPickerList extends StatefulWidget {
  const ColorPickerList({Key? key}) : super(key: key);

  @override
  State<ColorPickerList> createState() => _ColorPickerListState();
}

late StreamController streamController;
late CalendarEventModel calendarEventModel;
late List<ColorPickerRow> settingColorItems;

class _ColorPickerListState extends State<ColorPickerList> {
  @override
  void initState() {
    streamController = getit<StreamController<CalendarEventModel>>();
    calendarEventModel = getit<CalendarEventModel>();
    settingColorItems = [
      ColorPickerRow(
          title: "background",
          currentColor: calendarEventModel.calendarOptions.headerMonthBackColor,
          onChanged: (colorSelected) {
            calendarEventModel.calendarOptions.headerMonthBackColor =
                colorSelected;
            streamController.sink.add(calendarEventModel);
          }),
      ColorPickerRow(
          title: "selected day",
          currentColor: calendarEventModel.dayOptions.selectedBackgroundColor,
          onChanged: (colorSelected) {
            calendarEventModel.dayOptions.selectedBackgroundColor =
                colorSelected;
            streamController.sink.add(calendarEventModel);
          }),
      ColorPickerRow(
          title: "navigation",
          currentColor: calendarEventModel.headerOptions.navigationColor,
          onChanged: (colorSelected) {
            calendarEventModel.headerOptions.navigationColor = colorSelected;
            streamController.sink.add(calendarEventModel);
          }),
      ColorPickerRow(
          title: "headerText",
          currentColor: calendarEventModel.headerOptions.headerTextColor,
          onChanged: (colorSelected) {
            calendarEventModel.headerOptions.headerTextColor = colorSelected;
            streamController.sink.add(calendarEventModel);
          }),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: settingColorItems.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return settingColorItems[index];
      },
    );
  }
}
