import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:flutter_event_calendar/src/handlers/event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/event_selector.dart';
import 'package:flutter_event_calendar/src/handlers/translator.dart';
import 'package:flutter_event_calendar/src/models/calendar_options.dart';
import 'package:flutter_event_calendar/src/models/style/event_style.dart';
import 'package:flutter_event_calendar/src/widgets/event_card.dart';

class Events extends StatelessWidget {
  Function onEventsChanged;
  late EventStyle eventStyle;

  Events({required this.onEventsChanged});

  @override
  Widget build(BuildContext context) {
    eventStyle = EventStyle.of(context);
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
                  CalendarUtils.nextDay();
                  break;
                case false:
                  CalendarUtils.previousDay();
                  break;
              }
              onEventsChanged.call();
            } else {
              // right
              switch (EventCalendar.calendarProvider.isRTL()) {
                case true:
                  CalendarUtils.previousDay();
                  break;
                case false:
                  CalendarUtils.nextDay();
                  break;
              }
              onEventsChanged.call();
            }
          }),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: eventCardsMaker(context),
          ),
        ),
      ),
    );
  }

  List<Widget> eventCardsMaker(BuildContext context) {
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
            eventStyle.emptyIcon,
            size: 95,
            color: eventStyle.emptyIconColor,
          ),
          Text(
            '${eventStyle.emptyText != null ? eventStyle.emptyText : Translator.getTranslation('empty')}',
            style: TextStyle(
              color: eventStyle.emptyTextColor,
              fontSize: 25,
              fontFamily: CalendarOptions.of(context).font,
            ),
          ),
        ],
      ));

    return eventCards;
  }
}
