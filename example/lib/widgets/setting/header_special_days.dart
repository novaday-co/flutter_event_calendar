import 'package:flutter/material.dart';

import 'package:flutter_event_calendar/src/models/style/select_month_options.dart';
import 'package:flutter_event_calendar/src/models/style/select_year_options.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:flutter_event_calendar/src/widgets/select_month.dart';
import 'package:flutter_event_calendar/src/widgets/select_year.dart';
import 'package:flutter_event_calendar/src/widgets/select_day.dart';
import 'package:flutter_event_calendar_example/widgets/setting/data_picker_item.dart';
import 'package:flutter_event_calendar/src/models/datetime.dart';

class HeaderSpecialDays extends StatefulWidget {
  HeaderSpecialDays({Key? key,required this.speacialDate,required this.calendarDateTime}) : super(key: key);
  Function(CalendarDateTime calendarDateTime)  speacialDate;
  int day=1;


   CalendarDateTime calendarDateTime;
  @override
  State<HeaderSpecialDays> createState() => _HeaderSpecialDaysState();
}

class _HeaderSpecialDaysState extends State<HeaderSpecialDays> {
  @override
  Widget build(BuildContext context) {
    List<Widget> selectBottomSheetDate = [
      DataPickerItem(
        selectDate: SelectDay(
          onHeaderChanged: (int selectedDay) {
            setState(() {
              widget.calendarDateTime.day=selectedDay;
              widget.speacialDate(widget.calendarDateTime);
            });
          },
          dayStyle: YearOptions(selectedColor: Colors.blue),
        ),
        nameSelectDate: PartFormat.DAY,
      ),
      DataPickerItem(
        selectDate: SelectMonth(
          onHeaderChanged: (int selectedMonth) {
            setState(() {

              widget.calendarDateTime.month=selectedMonth;
           //   widget.speacialDate(widget.calendarDateTime);
            });
          },
          monthStyle: MonthOptions(selectedColor: Colors.blue),
        ),
        nameSelectDate: PartFormat.MONTH,
      ),
      DataPickerItem(
        selectDate: SelectYear(
          onHeaderChanged: (int selectedYear) {
            setState(() {
              widget.calendarDateTime.year=selectedYear;
            //  widget.speacialDate(widget.calendarDateTime);
            });
          },
          yearStyle: YearOptions(selectedColor: Colors.blue),
        ),
        nameSelectDate: PartFormat.YEAR,
      ),
    ];

    List<int> date = [widget.calendarDateTime.day, widget.calendarDateTime.month, widget.calendarDateTime.year];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectBottomSheetDate.length,
              itemBuilder: (BuildContext context, int index) {
                return selectBottomSheetDate[index];
              }),
        ),
        Container(
          height: 50,

          child: ListView.builder(
              itemCount: date.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(left: 30),
                  color: Colors.blue,
                  width: MediaQuery.of(context).size.width/3,
                  child: Text(

                   '${date[index]}',
                   textAlign: TextAlign.start,
                   style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                );

              }),
        )
      ],
    );
  }
}
