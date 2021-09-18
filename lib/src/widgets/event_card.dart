import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/event_calendar.dart';
import 'package:flutter_event_calendar/src/models/calendar_options.dart';
import 'package:flutter_event_calendar/src/models/event.dart';
import 'package:flutter_event_calendar/src/models/style/event_style.dart';

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
          color: EventStyle.of(context).backgroundColor,
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
                    color: EventStyle.of(context).titleColor,
                    fontFamily: CalendarOptions.of(context).font,
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
                    color: EventStyle.of(context).descriptionColor,
                    fontFamily: CalendarOptions.of(context).font,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${fullCalendarEvent.dateTime.toString()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: EventStyle.of(context).dateTimeColor,
                    fontFamily: CalendarOptions.of(context).font,
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
