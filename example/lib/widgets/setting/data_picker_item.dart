import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';
class DataPickerItem extends StatelessWidget {
   DataPickerItem({Key? key,required this.selectDate,required this.nameSelectDate}) : super(key: key);
Widget selectDate;
final PartFormat nameSelectDate;

@override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(nameSelectDate.name.toLowerCase(),style: TextStyle(fontWeight: FontWeight.bold),),
        TextButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext mmm) {
                  return selectDate;
                },
              );
            },
            child: Text("${CalendarUtils.getPartByInt(format:nameSelectDate)}")),
      ],
    );
  }
}
