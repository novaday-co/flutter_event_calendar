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
                      CalendarSelector().previousMonth();
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
                  buildRefreshView(),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
              // if (!isInTodayIndex()) buildRefreshView(),
              Row(
                children: [
                  SizedBox(width: 24),
                  InkWell(
                    customBorder: CircleBorder(),
                    onTap: () {
                      CalendarSelector().nextMonth();
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
    print(
        "${EventCalendar.dateTime.split(' ')[0]} == ${CalendarSelector().getCurrentDateTime().split(' ')[0]}");
    return EventCalendar.dateTime.split(' ')[0] ==
        CalendarSelector().getCurrentDateTime().split(' ')[0];
  }

  buildRefreshView() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: !isInTodayIndex() ? 1 : 0,
      child: Material(
        shape: CircleBorder(),
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: () {
            EventCalendar.dateTime =
                EventCalendar.calendarProvider.getDateTime();
            onHeaderChanged.call();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.restore,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
