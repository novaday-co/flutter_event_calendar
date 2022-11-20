import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../handlers/calendar_utils.dart';
import '../handlers/event_calendar.dart';
import '../handlers/event_selector.dart';
import '../handlers/translator.dart';
import '../models/calendar_options.dart';
import '../models/style/event_options.dart';
import 'event_card.dart';

class Events extends StatelessWidget {
  Function onEventsChanged;
  late EventOptions eventStyle;

  Events({required this.onEventsChanged});

  @override
  Widget build(BuildContext context) {
    eventStyle = EventOptions.of(context);
    List<Widget> events = eventCardsMaker(context);
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
          child: eventStyle.showLoadingForEvent?.call() == true
              ? eventStyle.loadingWidget!.call()
              : events.isEmpty
                  ? emptyView(context)
                  : ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: events,
                    ),
        ),
      ),
    );
  }

  List<Widget> eventCardsMaker(BuildContext context) {
    var selectedEvents = EventSelector().updateEvents();
    List<Widget> eventCards = [];
    for (var item in selectedEvents) {
      eventCards.add(
        EventCard(
          fullCalendarEvent: item,
        ),
      );
    }

    return eventCards;
  }
  Widget emptyView(BuildContext context){
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              eventStyle.emptyIcon,
              size: 95,
              color: eventStyle.emptyIconColor,
            ),
            Text(
              eventStyle.emptyText ??
                  Translator.getTranslation('empty'),
              style: TextStyle(
                color: eventStyle.emptyTextColor,
                fontSize: 25,
                fontFamily: CalendarOptions.of(context).font,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
