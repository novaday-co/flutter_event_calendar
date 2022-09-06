import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/widgets/setting/header_special_days.dart';

class SelectDatePicker extends StatefulWidget {
  SelectDatePicker(
      {Key? key,
      required this.onMonthChanged,
      required this.onYearChanged,
      required this.onDayChanged})
      : super(key: key);
  Function onMonthChanged;
  Function onYearChanged;
  Function onDayChanged;

  @override
  State<SelectDatePicker> createState() => _SelectDatePickerState();
}

class _SelectDatePickerState extends State<SelectDatePicker> {
  late StreamController streamController;

  bool existElement = false;
  int day = 1;
  int month = 6;
  int year = 1401;
  late CalendarDateTime calendarDateTime=CalendarDateTime(year: year, month: month, day: day, calendarType: CalendarUtils.getCalendarType(),color: Colors.green);
  late CalendarEventModel calendarEventModel;
  late List<CalendarDateTime> specialDayList;
  @override
  void initState() {

   calendarEventModel = getit<CalendarEventModel>();
  specialDayList = calendarEventModel.specialDays;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    streamController = getit<StreamController<CalendarEventModel>>();


     return Column(
       children: [
         HeaderSpecialDays(
           calendarDateTime:calendarDateTime
       ,speacialDate: (CalendarDateTime calendarDateTime){
           setState(() {
             calendarDateTime=calendarDateTime;
           });


         },),
         Row(
           children: [
             TextButton(
               onPressed: () {

                 //existElement= linearSearch(specialDayList,calendarDateTime,context);
                 //if(!existElement){
                   streamController.sink.add(calendarEventModel);

                     specialDayList.add(calendarDateTime);
                      // setState(() {
                      //
                      // });

                // }

               },
               child: Text("Add"),
             )
           ],
         ),
         specialDayList.length>0? ListView.separated(
           itemCount: specialDayList.length,
           shrinkWrap: true,
           itemBuilder: (BuildContext context, int index) {
             return Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Text(calendarDateTime.day.toString()),
                 Text(specialDayList[index].month.toString()),
                 Text(specialDayList[index].year.toString()),
                 IconButton(onPressed: (){
                  // setState(() {
                     specialDayList.removeAt(index);
                 //  });
                 }, icon: Icon(Icons.delete))
               ],
             );
           },
           separatorBuilder: (BuildContext context, int index) => Divider(),
         ): Container()
       ],
     );
  }
}

bool linearSearch(List<CalendarDateTime> array,
    CalendarDateTime calendarDateTime, BuildContext context) {
  for (int i = 0; i < array.length; i++) {
    if (array[i].year == calendarDateTime.year &&
        array[i].month == calendarDateTime.month &&
        array[i].day == calendarDateTime.day) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("this date already exist"),
      ));

      return true;
    }
  }
  return false;
}
