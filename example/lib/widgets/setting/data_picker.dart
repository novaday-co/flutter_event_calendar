import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/widgets/select_month.dart';
import 'package:flutter_event_calendar/src/widgets/select_year.dart';
import 'package:flutter_event_calendar/src/widgets/select_day.dart';
import 'package:flutter_event_calendar/src/models/style/select_month_options.dart';
import 'package:flutter_event_calendar/src/models/style/select_year_options.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';
import 'package:flutter_event_calendar_example/widgets/setting/data_picker_item.dart';

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
  List<CalendarDateTime> specialDayList = [];
  bool existElement=false;
  @override
  Widget build(BuildContext context) {

    CalendarDateTime calendarDateTime;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              ("day"),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("month", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("year", style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DataPickerItem(
              selectDate: SelectDay(
                onHeaderChanged: widget.onDayChanged,
                dayStyle: YearOptions(selectedColor: Colors.blue),
              ),
              nameSelectDate: PartFormat.DAY,
            ),
            DataPickerItem(
              selectDate: SelectMonth(
                onHeaderChanged: widget.onMonthChanged,
                monthStyle: MonthOptions(selectedColor: Colors.blue),
              ),
              nameSelectDate: PartFormat.MONTH,
            ),
            DataPickerItem(
              selectDate: SelectYear(
                onHeaderChanged: widget.onYearChanged,
                yearStyle: YearOptions(selectedColor: Colors.blue),
              ),
              nameSelectDate: PartFormat.YEAR,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: TextButton(
              onPressed: () {
                calendarDateTime = CalendarDateTime(
                    day: CalendarUtils.getPartByInt(
                      format: PartFormat.DAY,
                    ),
                    month: CalendarUtils.getPartByInt(
                      format: PartFormat.MONTH,
                    ),
                    year: CalendarUtils.getPartByInt(
                      format: PartFormat.YEAR,
                    ),
                    calendarType: CalendarUtils.getCalendarType());


                existElement= linearSearch(specialDayList,calendarDateTime,context);

               if(!existElement){
                 setState(() {
                   specialDayList.add(calendarDateTime);
                 });
               }


              },
              child: Text("Add"),
            ))
          ],
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


bool linearSearch(List<CalendarDateTime> array, CalendarDateTime calendarDateTime,BuildContext context) {
  for(int i = 0; i< array.length; i++){
    if(array[i].year == calendarDateTime.year && array[i].month== calendarDateTime.month&& array[i].day== calendarDateTime.day){

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("this date already exist"),
      ));

      return true;

    }

  }
return false;
}