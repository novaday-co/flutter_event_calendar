import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:flutter_event_calendar/src/models/style/select_month_options.dart';
import 'package:flutter_event_calendar/src/models/style/select_year_options.dart';
import 'package:flutter_event_calendar/src/widgets/select_month.dart';
import 'package:flutter_event_calendar/src/widgets/select_year.dart';
typedef ViewTypeChangeCallback = Function(ViewType);

class Header extends StatelessWidget {
  ViewTypeChangeCallback? onViewTypeChanged;
  Function onDateTimeReset;
  Function(int selectedYear) onYearChanged;
  Function(int selectedMonth) onMonthChanged;
  Header({required this.onViewTypeChanged,required this.onYearChanged,required this.onMonthChanged,required this.onDateTimeReset});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Directionality(
          textDirection: EventCalendar.calendarProvider.isRTL() ? TextDirection.rtl : TextDirection.ltr,
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
                      onMonthChanged.call(CalendarUtils.getPartByInt(format:PartFormat.MONTH));
                    },
                    customBorder: CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: HeaderOptions.of(context).navigationColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: EventCalendar.calendarProvider.isRTL() ? Alignment.centerRight : Alignment.centerLeft,
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
                                onHeaderChanged: onMonthChanged,
                                monthStyle: MonthOptions(
                                  font: CalendarOptions.of(context).font,
                                  selectedColor: DayOptions.of(context)
                                      .selectedBackgroundColor,
                                  backgroundColor: CalendarOptions.of(context).bottomSheetBackColor
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            '${CalendarUtils.getPartByString(
                              format: PartFormat.MONTH,
                              options: HeaderOptions.of(context),
                            )}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: HeaderOptions.of(context).headerTextColor,
                              fontFamily: CalendarOptions.of(context).font,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext mmm) {
                              return SelectYear(
                                onHeaderChanged: onYearChanged,
                                yearStyle: YearOptions(
                                  font: CalendarOptions.of(context).font,
                                  selectedColor: DayOptions.of(context)
                                      .selectedBackgroundColor,
                                    backgroundColor: CalendarOptions.of(context).bottomSheetBackColor
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          '${CalendarUtils.getPartByInt(format: PartFormat.YEAR)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: HeaderOptions.of(context).headerTextColor,
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
                  buildRefreshView(context),
                  buildSelectViewType(context),
                  InkWell(
                    customBorder: CircleBorder(),
                    onTap: () {
                      CalendarUtils.goToDay(1);
                      CalendarUtils.nextMonth();
                      onMonthChanged.call(CalendarUtils.getPartByInt(format:PartFormat.MONTH));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: HeaderOptions.of(context).navigationColor,
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
    return EventCalendar.dateTime!.isDateEqual(EventCalendar.calendarProvider.getDateTime());
  }

  buildRefreshView(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: !isInTodayIndex() ? 1 : 0,
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: () {
          EventCalendar.dateTime = EventCalendar.calendarProvider.getDateTime();
          onDateTimeReset.call();
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            Icons.restore,
            size: 24,
            color: HeaderOptions.of(context).headerTextColor,
          ),
        ),
      ),
    );
  }

  buildSelectViewType(BuildContext context) {
    if (CalendarOptions.of(context).toggleViewType) {
      return InkWell(
        customBorder: CircleBorder(),
        onTap: () {
          // EventCalendar.dateTime = EventCalendar.calendarProvider.getDateTime();
          if (CalendarOptions.of(context).viewType == ViewType.MONTHLY) {
            CalendarOptions.of(context).viewType = ViewType.DAILY;
          } else {
            CalendarOptions.of(context).viewType = ViewType.MONTHLY;
          }
          onViewTypeChanged?.call(CalendarOptions.of(context).viewType);
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            CalendarOptions.of(context).viewType == ViewType.MONTHLY
                ? Icons.calendar_today_outlined
                : Icons.calendar_today_outlined,
            size: 18,
            color: HeaderOptions.of(context).calendarIconColor,
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
