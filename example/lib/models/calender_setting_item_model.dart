
import 'package:flutter/material.dart';

class CalendarSettingItem {
  CalendarSettingItem({
    @required this.id,
    @required this.expandedValue,
    @required this.headerValue,
  });

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

