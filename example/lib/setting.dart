
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar_example/widgets/radio_button_list.dart';

import '../models/calender_setting_item_model.dart';


class CalendarSetting extends StatefulWidget {
  const CalendarSetting({Key key}) : super(key: key);

  @override
  State<CalendarSetting> createState() => _CalendarSettingState();
}

class _CalendarSettingState extends State<CalendarSetting> {

  @override
  Widget build(BuildContext context) {
    final List<Item> _items = [Item(title: "JALALI",id: 0), Item(title: "GREGORIAN",id: 1)];
    final List<Item> _items_calendar_language = [Item(title: "ENGLISH"), Item(title: "FARSI")];
    final List<Item> _month_stringTypes = [Item(title: "FULL"), Item(title: "SHORT")];

    final List<CalendarSettingItem> _data = [
      CalendarSettingItem(
          id: 0, expandedValue: _items, headerValue: "Calendar Type"),
      CalendarSettingItem(
          id: 1, expandedValue: _items_calendar_language, headerValue: "Calendar Language"),
      CalendarSettingItem(
          id: 2, expandedValue: _month_stringTypes, headerValue: "Month String Types")
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: _buildPanel(_data,_items),
          ),
        ),
      ),
    );
  }



  Widget _buildPanel(List<CalendarSettingItem> _data,List<Item> _items) {
    int _character=1;
    return ExpansionPanelList.radio(
      initialOpenPanelValue: 1,
      children: _data.map<ExpansionPanelRadio>((CalendarSettingItem item) {
        return ExpansionPanelRadio(
            value: item.id,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Container(margin: EdgeInsets.symmetric(horizontal: 10),alignment: Alignment.centerLeft,child: Text(item.headerValue,style: TextStyle(fontWeight: FontWeight.bold),));
            },
            body:  RadioButtonListWidget(calendarSettingItem:item));
      }).toList(),
    );
  }
}