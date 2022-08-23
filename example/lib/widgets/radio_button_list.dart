
import 'package:flutter/material.dart';
import '../models/calendar_event_model.dart';
import '../models/calender_setting_item_model.dart';
//ValueNotifier<CalendarEventModel> calendarEventModel=ValueNotifier<CalendarEventModel>(getIt.get<CalendarEventModel>());

class RadioButtonListWidget extends StatefulWidget {
  RadioButtonListWidget({Key key,@required this.calendarSettingItem}) : super(key: key);
  CalendarSettingItem calendarSettingItem;
  @override
  State<RadioButtonListWidget> createState() => _RadioButtonListWidgetState();
}
class _RadioButtonListWidgetState extends State<RadioButtonListWidget> {
  String groubValueKey="parisima";

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          RadioListTile(title: Text(widget.calendarSettingItem.expandedValue[0].title),
            value: widget.calendarSettingItem.expandedValue[0].title,
            groupValue: groubValueKey,
            onChanged: (value) {
              //calendarEventModel.value.calendarLanguage=value;
              setState(() {
                groubValueKey = value;

              });
            },),
          RadioListTile(title:Text(widget.calendarSettingItem.expandedValue[1].title),
              value: widget.calendarSettingItem.expandedValue[1].title,
              groupValue: groubValueKey,
              onChanged: (value) {
                setState(() {
                  groubValueKey = value;
                });
              }),
        ],
      ),

    );
  }
}