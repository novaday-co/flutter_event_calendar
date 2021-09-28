import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:flutter_event_calendar/src/handlers/event_calendar.dart';
import 'package:flutter_event_calendar/src/models/calendar_options.dart';
import 'package:flutter_event_calendar/src/models/style/headers_style.dart';
import 'package:flutter_event_calendar/src/models/style/select_month_style.dart';
import 'package:flutter_event_calendar/src/models/style/select_year_style.dart';
import 'package:flutter_event_calendar/src/widgets/select_month.dart';
import 'package:flutter_event_calendar/src/widgets/select_year.dart';

class Header extends StatelessWidget {
  Function onHeaderChanged;

  Header({required this.onHeaderChanged});

  @override
  Widget build(BuildContext context) {
    return Material(
      color:Colors.white,
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
                      CalendarUtils.goToDay(1);
                      CalendarUtils.previousMonth();
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
                            builder: (BuildContext mmm) {
                              return SelectMonth(
                                onHeaderChanged: onHeaderChanged,
                                monthStyle: MonthStyle(
                                  font: CalendarOptions.of(context).font,
                                  selectedColor: DayStyle.of(context)
                                      .selectedBackgroundColor,
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            '${CalendarUtils.getPartByString(
                              format: PartFormat.month,
                              options: HeadersStyle.of(context),
                            )}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              fontFamily: CalendarOptions.of(context).font,
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
                            builder: (BuildContext mmm) {
                              return SelectYear(
                                onHeaderChanged: onHeaderChanged,
                                yearStyle: YearStyle(
                                  font: CalendarOptions.of(context).font,
                                  selectedColor: DayStyle.of(context)
                                      .selectedBackgroundColor,
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          '${CalendarUtils.getPartByInt(format: PartFormat.year)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            fontFamily: CalendarOptions.of(context).font,
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
                  buildSelectViewType(context),
                  InkWell(
                    customBorder: CircleBorder(),
                    onTap: () {
                      CalendarUtils.goToDay(1);
                      CalendarUtils.nextMonth();
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
    return EventCalendar.dateTime
        .isDateEqual(EventCalendar.calendarProvider.getDateTime());
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

  buildSelectViewType(BuildContext context) {
    if (CalendarOptions.of(context).toggleViewType)
      return InkWell(
        customBorder: CircleBorder(),
        onTap: () {
          // EventCalendar.dateTime = EventCalendar.calendarProvider.getDateTime();
          if (CalendarOptions.of(context).viewType == ViewType.Monthly)
            CalendarOptions.of(context).viewType = ViewType.Daily;
          else
            CalendarOptions.of(context).viewType = ViewType.Monthly;
          onHeaderChanged.call();
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            CalendarOptions.of(context).viewType == ViewType.Monthly
                ? Icons.calendar_view_month_outlined
                : Icons.calendar_view_day_outlined,
            size: 24,
          ),
        ),
      );
    return SizedBox();
  }
}
