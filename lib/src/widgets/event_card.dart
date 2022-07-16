import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/models/event.dart';

class EventCard extends StatelessWidget {
  Event fullCalendarEvent;

  EventCard({required this.fullCalendarEvent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        fullCalendarEvent.onTap?.call(fullCalendarEvent.listIndex);
      }),
      onLongPress: (() {
        fullCalendarEvent.onLongPress?.call(fullCalendarEvent.listIndex);
      }),
      child: fullCalendarEvent.child,
    );
  }
}
