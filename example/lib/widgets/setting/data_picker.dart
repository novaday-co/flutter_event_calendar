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
  int day=1;
  int month=6;
  int year=1401;
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
            DataPickerItem(
              selectDate: SelectDay(
                onHeaderChanged: (int day){
                  setState(() {
                    widget.day=day;
                  });
                },
                dayStyle: YearOptions(selectedColor: Colors.blue),
              ),
              nameSelectDate: PartFormat.DAY,
            ),
            DataPickerItem(
              selectDate: SelectMonth(
                onHeaderChanged:(int selectedMonth){
                  setState(() {
                    widget.month=selectedMonth;
                  });
                },
                monthStyle: MonthOptions(selectedColor: Colors.blue),
              ),
              nameSelectDate: PartFormat.MONTH,
            ),
            DataPickerItem(
              selectDate: SelectYear(
                onHeaderChanged: (int selectedYear){
                  widget.year=selectedYear;
                },
                yearStyle: YearOptions(selectedColor: Colors.blue),
              ),
              nameSelectDate: PartFormat.YEAR,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('${widget.day}', style: TextStyle(fontWeight: FontWeight.bold),),
            Text('${widget.month}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('${widget.year}', style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
            calendarDateTime = CalendarDateTime(
                day: widget.day,
                month: widget.month,
                year: widget.year,
                calendarType: CalendarUtils.getCalendarType());
            existElement= linearSearch(specialDayList,calendarDateTime,context);
               if(!existElement){
             setState(() {
               specialDayList.add(calendarDateTime);
             });
               }
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