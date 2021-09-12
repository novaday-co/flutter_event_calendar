import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/event_calendar.dart';
import 'package:flutter_event_calendar/src/models/event.dart';

class EventCard extends StatelessWidget {
  Event fullCalendarEvent;

  EventCard({required this.fullCalendarEvent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 7, right: 7),
      child: GestureDetector(
        onTap: (() {
          fullCalendarEvent.onTap?.call(fullCalendarEvent.listIndex);
        }),
        onLongPress: (() {
          fullCalendarEvent.onLongPress?.call(fullCalendarEvent.listIndex);
        }),
        child: Card(
          color: EventCalendar.eventBackgroundColor,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: EventCalendar.calendarProvider.isRTL()
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  '${fullCalendarEvent.title}',
                  textDirection: EventCalendar.calendarProvider.isRTL()
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: EventCalendar.eventTitleColor,
                    fontFamily: EventCalendar.font,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${fullCalendarEvent.description}',
                  textDirection: EventCalendar.calendarProvider.isRTL()
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 13,
                    color: EventCalendar.eventDescriptionColor,
                    fontFamily: EventCalendar.font,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${fullCalendarEvent.dateTime.toString()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: EventCalendar.eventDateTimeColor,
                    fontFamily: EventCalendar.font,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
