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
  int day = CalendarUtils.getPartByInt(format: PartFormat.DAY);
  int month = CalendarUtils.getPartByInt(format: PartFormat.MONTH);
  int year = CalendarUtils.getPartByInt(format: PartFormat.YEAR);
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
    CalendarDateTime calendarDateTime=CalendarDateTime(year: year, month: month, day: day, calendarType: CalendarUtils.getCalendarType(),color: Colors.green);


    return Column(
       children: [
         HeaderSpecialDays(
           calendarDateTime:calendarDateTime
       ,speacialDate: (CalendarDateTime calendarDateTimee){
             year=calendarDateTimee.year;
             day=calendarDateTimee.day;
             month=calendarDateTimee.month;
           calendarDateTime=calendarDateTimee;
         },),
         Container(
           margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
           child: TextButton(
             style: ElevatedButton.styleFrom(
               primary: Colors.blue,
             minimumSize: const Size.fromHeight(10),
             ),
             onPressed: () {

              existElement= linearSearch(specialDayList,calendarDateTime,context);
              if(!existElement){
                 streamController.sink.add(calendarEventModel);
                 specialDayList.add(calendarDateTime);

             }

             },
             child: Text("Add",style: TextStyle(color: Colors.white),),
           ),
         ),
         specialDayList.length>0? ListView.separated(
           itemCount: specialDayList.length,
           shrinkWrap: true,
           itemBuilder: (BuildContext context, int index) {
             return Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Text(specialDayList[index].day.toString()),
                 Text(specialDayList[index].month.toString()),
                 Text(specialDayList[index].year.toString()),
                 IconButton(onPressed: (){
                   setState(() {
                     specialDayList.removeAt(index);
                 });
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
