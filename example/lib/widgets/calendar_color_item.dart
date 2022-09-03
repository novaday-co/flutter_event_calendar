import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/widgets/color_picker_row.dart';



class ColorPickerList extends StatefulWidget {
  const ColorPickerList({Key? key}) : super(key: key);

  @override
  State<ColorPickerList> createState() => _ColorPickerListState();
}
// create some values
late StreamController streamController;
late CalendarEventModel calendarEventModel;


class _ColorPickerListState extends State<ColorPickerList> {

  @override
  Widget build(BuildContext context) {
     streamController =getit<StreamController<CalendarEventModel>>();
     calendarEventModel = getit<CalendarEventModel>();
     List<ColorPickerRow> listThemeOptions=[
       ColorPickerRow(title: "backgoround",currentColor: calendarEventModel.calendarOptions.headerMonthBackColor
           ,onChanged:  (dynamic colorSelected){
        calendarEventModel.calendarOptions.headerMonthBackColor=colorSelected;
        streamController.sink.add(calendarEventModel);
       }
       ),
       ColorPickerRow(title: "color selected",currentColor: calendarEventModel.dayOptions.selectedBackgroundColor
           ,onChanged:  (dynamic colorSelected){
        calendarEventModel.dayOptions.selectedBackgroundColor=colorSelected;
        streamController.sink.add(calendarEventModel);
       }
       ),

     ];
    return ListView.builder(
      itemCount: listThemeOptions.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return  listThemeOptions[index];
      },
    );
  }
}






