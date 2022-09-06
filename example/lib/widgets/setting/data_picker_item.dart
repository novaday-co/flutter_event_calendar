import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';
class DataPickerItem extends StatefulWidget {
   DataPickerItem({Key? key,required this.selectDate,required this.nameSelectDate,

   }) : super(key: key);
Widget selectDate;
final PartFormat nameSelectDate;

  @override
  State<DataPickerItem> createState() => _DataPickerItemState();
}

class _DataPickerItemState extends State<DataPickerItem> {
  @override
  void initState() {




    super.initState();
  }
//Function(int n) changeDate;
@override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext mmm) {
                  return widget.selectDate;
                },
              );
            },
            child: Text(widget.nameSelectDate.name)),
      ],
    );
  }
}
