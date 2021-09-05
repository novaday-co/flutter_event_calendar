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
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          top: 15,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // Title , next and previous button
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      CalendarSelector().nextMonth();
                      onHeaderChanged.call();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                      ),
                    ),
                  ),
                  if (!isInTodayIndex()) buildRefreshView(),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  textDirection: EventCalendar.calendarProvider.isRTL()
                      ? TextDirection.rtl
                      : TextDirection.ltr,
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
            InkWell(
              onTap: () {
                CalendarSelector().previousMonth();
                onHeaderChanged.call();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  isInTodayIndex() {
    return EventCalendar.dateTime.split(' ')[0] ==
        CalendarSelector().getCurrentDateTime();
  }

  buildRefreshView() {
    return Material(
      shape: CircleBorder(),
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: () {
          EventCalendar.dateTime = EventCalendar.calendarProvider.getDateTime();
          onHeaderChanged.call();
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(Icons.restore),
        ),
      ),
    );
  }
}
