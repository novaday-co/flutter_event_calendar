import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/widgets/SelectMonth.dart';
import 'package:flutter_event_calendar/src/widgets/SelectYear.dart';

class Header extends StatelessWidget {
  Function onHeaderChanged;

  Header({required this.onHeaderChanged});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Directionality(
          textDirection: EventCalendar.calendarProvider.isRTL()
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // Title , next and previous button
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      final selector = CalendarSelector();
                      selector.goToDay(1);
                      selector.previousMonth();
                      onHeaderChanged.call();
                    },
                    customBorder: CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: EventCalendar.calendarProvider.isRTL()
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return SelectMonth(
                                onHeaderChanged: onHeaderChanged,
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            '${CalendarSelector().getPart(format: PartFormat.month, responseType: 'string')}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              fontFamily: EventCalendar.font,
                            ),
                          ),
                        ),
                      ),
                      Text(' , '),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return SelectYear(
                                onHeaderChanged: onHeaderChanged,
                              );
                            },
                          );
                        },
                        child: Text(
                          '${CalendarSelector().getPart(format: PartFormat.year, responseType: 'int')}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            fontFamily: EventCalendar.font,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // if (!isInTodayIndex()) buildRefreshView(),
              Row(
                children: [
                  buildRefreshView(),
                  buildSelectViewType(),
                  InkWell(
                    customBorder: CircleBorder(),
                    onTap: () {
                      final selector = CalendarSelector();
                      selector.goToDay(1);
                      selector.nextMonth();
                      onHeaderChanged.call();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  isInTodayIndex() {
    return EventCalendar.dateTime.split(' ')[0] ==
        CalendarSelector().getCurrentDateTime().split(' ')[0];
  }

  buildRefreshView() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: !isInTodayIndex() ? 1 : 0,
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: () {
          EventCalendar.dateTime = EventCalendar.calendarProvider.getDateTime();
          onHeaderChanged.call();
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            Icons.restore,
            size: 24,
          ),
        ),
      ),
    );
  }

  buildSelectViewType() {
    if (EventCalendar.canSelectViewType)
      return InkWell(
        customBorder: CircleBorder(),
        onTap: () {
          // EventCalendar.dateTime = EventCalendar.calendarProvider.getDateTime();
          if (EventCalendar.viewType == CalendarViewType.Monthly)
            EventCalendar.viewType = CalendarViewType.Daily;
          else
            EventCalendar.viewType = CalendarViewType.Monthly;
          onHeaderChanged.call();
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            EventCalendar.viewType == CalendarViewType.Monthly
                ? Icons.calendar_view_month_outlined
                : Icons.calendar_view_day_outlined,
            size: 24,
          ),
        ),
      );
    return SizedBox();
  }
}
