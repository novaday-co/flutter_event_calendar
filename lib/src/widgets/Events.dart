import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/handlers/EventSelector.dart';
import 'package:flutter_event_calendar/src/handlers/Translator.dart';
import 'package:flutter_event_calendar/src/widgets/EventCard.dart';

class Events extends StatelessWidget {
  Function onEventsChanged;

  Events({required this.onEventsChanged});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: GestureDetector(
          onPanEnd: ((details) {
            Velocity vc = details.velocity;
            String clearVc;
            clearVc = vc.toString().replaceAll('(', '');
            clearVc = clearVc.toString().replaceAll(')', '');
            clearVc = clearVc.toString().replaceAll('Velocity', '');
            if (double.parse(clearVc.toString().split(',')[0]) > 0) {
              // left
              switch (EventCalendar.calendarProvider.isRTL()) {
                case true:
                  CalendarSelector().nextDay();
                  break;
                case false:
                  CalendarSelector().previousDay();
                  break;
              }
              onEventsChanged.call();
            } else {
              // right
              switch (EventCalendar.calendarProvider.isRTL()) {
                case true:
                  CalendarSelector().previousDay();
                  break;
                case false:
                  CalendarSelector().nextDay();
                  break;
              }
              onEventsChanged.call();
            }
          }),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: eventCardsMaker(),
          ),
        ),
      ),
    );
  }

  List<Widget> eventCardsMaker() {
    var selectedEvents = EventSelector().updateEvents();
    List<Widget> eventCards = [];
    for (var item in selectedEvents)
      eventCards.add(
        EventCard(
          fullCalendarEvent: item,
        ),
      );

    if (selectedEvents.length == 0)
      eventCards.add(Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Icon(
            EventCalendar.emptyIcon,
            size: 95,
            color: EventCalendar.emptyIconColor,
          ),
          Text(
            '${EventCalendar.emptyText != null ? EventCalendar.emptyText : Translator().trans('empty')}',
            style: TextStyle(
              color: EventCalendar.emptyTextColor,
              fontSize: 25,
              fontFamily: EventCalendar.font,
            ),
          ),
        ],
      ));

    return eventCards;
  }
}
