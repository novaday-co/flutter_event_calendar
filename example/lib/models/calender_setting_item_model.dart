
import 'package:flutter/material.dart';

class CalendarSettingItem {
  CalendarSettingItem({
    @required this.filed,
    @required this.id,
    @required this.expandedValue,
    @required this.headerValue,
  });

  String filed;
  int id;
  List<Item> expandedValue;
  String headerValue;
}

class Item {
  Item({
    @required this.title,
    @required this.id
  });
  String title;
  int id;
}

