import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:scoped_model/scoped_model.dart';

class EventStyle extends Model {
  String? emptyText;
  Color emptyTextColor;
  IconData emptyIcon;
  Color emptyIconColor;
  Color eventBackgroundColor;
  Color eventTitleColor;
  Color eventDescriptionColor;
  Color eventDateTimeColor;

  EventStyle(
      {this.emptyText,
      this.emptyTextColor = const Color(0xffe5e5e5),
      this.emptyIcon = Icons.reorder,
      this.emptyIconColor = const Color(0xffebebeb),
      this.eventBackgroundColor = Colors.white,
      this.eventTitleColor = Colors.black,
      this.eventDescriptionColor = Colors.grey,
      this.eventDateTimeColor = Colors.grey});

  static EventStyle of(BuildContext context) => ScopedModel.of<EventStyle>(context);
}
