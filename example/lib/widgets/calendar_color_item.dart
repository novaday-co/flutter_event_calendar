import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/widgets/color_picker_row.dart';



class CalendarColorItem extends StatefulWidget {
  const CalendarColorItem({Key key}) : super(key: key);

  @override
  State<CalendarColorItem> createState() => _CalendarColorItemState();
}
// create some values
StreamController streamController;
CalendarEventModel calendarEventModel;


class _CalendarColorItemState extends State<CalendarColorItem> {

  @override
  Widget build(BuildContext context) {
     streamController =getit<StreamController<CalendarEventModel>>();
     calendarEventModel = getit<CalendarEventModel>();
     List<ColorPickerRow> listThemeOptions=[
       ColorPickerRow(title: "backgoround",onChanged:  (dynamic colorSelected){
        calendarEventModel.calendarOptions.headerMonthBackColor=colorSelected;
        streamController.sink.add(calendarEventModel);
       }
       ),
       ColorPickerRow(title: "color selected",onChanged:  (dynamic colorSelected){
        calendarEventModel.dayOptions.selectedBackgroundColor=colorSelected;
        streamController.sink.add(calendarEventModel);
       }
       ),

     ];
    return Container(
      child: Container(
      child: ListView.builder(
        itemCount: listThemeOptions.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return  listThemeOptions[index];
        },
      ),
      ),
    );
  }
}






