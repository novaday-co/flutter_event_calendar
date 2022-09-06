import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/widgets/setting/data_picker_item.dart';
import 'package:flutter_event_calendar/src/widgets/select_day.dart';

class DateWidget extends StatelessWidget {
   DateWidget({Key? key,required this.dataPickerItem}) : super(key: key);
  DataPickerItem dataPickerItem;
  @override
  Widget build(BuildContext context) {
    return dataPickerItem;
  }
}

abstract class DateItemBottomSheet{

  Widget body;

  DateItemBottomSheet({ required this.body});

}


class DayItem extends DateItemBottomSheet{

  DayItem({required Widget body}) : super(body: body);

  factory DayItem.day(Widget body){
    return  DayItem(
      body:body,
     );
  }

  factory DayItem.month(Widget body){
    return  DayItem(
      body:body,
    );
  }

}

class DayItemm implements DayItem{
  @override
  late Widget body;


}

