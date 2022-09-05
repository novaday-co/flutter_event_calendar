import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/widgets/select_month.dart';
import 'package:flutter_event_calendar/src/widgets/select_year.dart';
import 'package:flutter_event_calendar/src/widgets/select_day.dart';
import 'package:flutter_event_calendar/src/models/style/select_month_options.dart';
import 'package:flutter_event_calendar/src/models/style/select_year_options.dart';

import 'package:flutter_event_calendar_example/widgets/setting/data_picker_item.dart';
class SelectDatePicker extends StatelessWidget {
  SelectDatePicker(
      {Key? key, required this.onMonthChanged, required this.onYearChanged,required this.onDayChanged})
      : super(key: key);
  Function onMonthChanged;
  Function onYearChanged;
  Function onDayChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DataPickerItem(selectDate:SelectDay(onHeaderChanged: onDayChanged,dayStyle: YearOptions(selectedColor: Colors.blue),),nameSelectDate: PartFormat.DAY,),
            DataPickerItem(selectDate:SelectMonth(onHeaderChanged: onMonthChanged,monthStyle: MonthOptions(selectedColor: Colors.blue),),nameSelectDate: PartFormat.MONTH,),
            DataPickerItem(selectDate:SelectYear(onHeaderChanged: onDayChanged,yearStyle: YearOptions(selectedColor: Colors.blue),),nameSelectDate: PartFormat.YEAR,),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: Text("Add"),
                ))
          ],
        )
      ],
    );
  }
}