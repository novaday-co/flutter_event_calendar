import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_monthly_utils.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:flutter_event_calendar/src/handlers/event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/event_selector.dart';
import 'package:flutter_event_calendar/src/handlers/translator.dart';
import 'package:flutter_event_calendar/src/models/calendar_options.dart';
import 'package:flutter_event_calendar/src/models/style/headers_options.dart';
import 'package:flutter_event_calendar/src/models/style/highlight_painter.dart';
import 'package:flutter_event_calendar/src/utils/style_provider.dart';
import 'package:flutter_event_calendar/src/widgets/day.dart';

class CalendarMonthly extends StatefulWidget {
  Function onCalendarChanged;
  List<CalendarDateTime> specialDays;
  bool multiSelection;
  Function(List<CalendarDateTime> selectedRange) selectedDaysRangeCallBack;
  CalendarMonthly(
      {required this.specialDays,
        required this.onCalendarChanged,
        required this.multiSelection,
        required this.selectedDaysRangeCallBack,
        Key? key})
      : super();

  @override
  State<CalendarMonthly> createState() => _CalendarMonthlyState();
}

class _CalendarMonthlyState extends State<CalendarMonthly> {


  EventSelector eventSelector = EventSelector();
  late DayOptions dayOptions;
  late List<String> dayNames;
  late HeaderOptions headersStyle;
  int currMonth = -1;
  int currYear = -1;
  List<CalendarDateTime> selectedDaysRange = [];
  bool full = false;
  late CalendarDateTime selectedDayStart;
  String selectedDaysRangeListString = '';
  late CalendarDateTime selectedDayEnd ;

  @override
  void initState() {
    headersStyle = HeaderOptions.of(context);
    dayOptions = DayOptions.of(context);
    dayNames = Translator.getNameOfDay(headersStyle.weekDayStringType);
    selectedDayStart = CalendarDateTime(
        year: CalendarUtils.getPartByInt(format: PartFormat.YEAR),
        month: CalendarUtils.getPartByInt(format: PartFormat.MONTH),
        day: CalendarUtils.getPartByInt(format: PartFormat.DAY),
        calendarType: CalendarUtils.getCalendarType());
    selectedDayEnd = CalendarDateTime(year: -1,
    month: CalendarUtils.getPartByInt(format: PartFormat.MONTH),
    day: -1,
    calendarType: CalendarUtils.getCalendarType());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    currMonth = CalendarUtils.getPartByInt(format: PartFormat.MONTH);
    currYear = CalendarUtils.getPartByInt(format: PartFormat.YEAR);
    super.didChangeDependencies();
  }



  void changeDay() {
    if (widget.multiSelection == false) {
      selectedDaysRange.clear();
      _activeSingleSelection();
    }else if (widget.multiSelection == true) {
      _activeMultiSelection();
      listSelectedDays();
    }
  }

  void activeSingleSelectionInMonthChange() {
    if (widget.multiSelection == false) {
      selectedDaysRange.clear();
      _activeSingleSelection();
    }
  }

  listSelectedDays() {
    selectedDaysRange.clear();
    selectedDaysRange = selectedDayStart.daysRange(selectedDayStart, selectedDayEnd );
     (selectedDaysRange.length == 0) ?selectedDayStartPointToSelectedDayEnd(): widget.selectedDaysRangeCallBack(selectedDaysRange);
  }





  _activeSingleSelection()  {
    _disableSelectedEnd();
    selectedDayStart.day = CalendarUtils.getPartByInt(format: PartFormat.DAY);
    selectedDayStart.month = CalendarUtils.getPartByInt(format: PartFormat.MONTH);
    selectedDayStart.year = CalendarUtils.getPartByInt(format: PartFormat.YEAR);
    selectedDayStart.daysInMonth = CalendarMonthlyUtils.getLastDayOfMonth(headersStyle);
  }
  _activeMultiSelection()  {
    selectedDayEnd.day = CalendarUtils.getPartByInt(format: PartFormat.DAY);
    selectedDayEnd.month =
        CalendarUtils.getPartByInt(format: PartFormat.MONTH);
    selectedDayEnd.year = CalendarUtils.getPartByInt(format: PartFormat.YEAR);
  }

  @override
  void didUpdateWidget(covariant CalendarMonthly oldWidget) {
    dayNames = Translator.getNameOfDay(headersStyle.weekDayStringType);
    currMonth = CalendarUtils.getPartByInt(format: PartFormat.MONTH);
    currYear= CalendarUtils.getPartByInt(format: PartFormat.YEAR);
    activeSingleSelectionInMonthChange();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!dayOptions.compactMode) ...[
            _buildDayName(),
          ],
          SizedBox(
            height: 12,
          ),
          _buildMonthView()
        ],
      ),
    );
  }

  _buildDayName() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      textDirection: EventCalendar.calendarProvider.isRTL()
          ? TextDirection.rtl
          : TextDirection.ltr,
      children: List.generate(7, (index) {
        final dayName = CalendarMonthlyUtils.getDayNameOfMonth(
            headersStyle, currMonth, EventCalendar.dateTime!.day);
        return Expanded(
          child: Center(
            heightFactor: 1,
            child: RotatedBox(
              quarterTurns:
              headersStyle.weekDayStringType == WeekDayStringTypes.FULL
                  ? 3
                  : 0,
              child: Text(
                dayNames[index],
                style: TextStyle(
                    color: dayNames[index] == dayName ? Colors.red : null,
                    fontSize: 15,
                    fontFamily: CalendarOptions
                        .of(context)
                        .font),
              ),
            ),
          ),
        );
      }),
    );
  }

  _buildMonthView() {
    final int firstDayIndex =
    CalendarMonthlyUtils.getFirstDayOfMonth(dayNames, headersStyle);
    final int lastDayIndex =
        firstDayIndex + CalendarMonthlyUtils.getLastDayOfMonth(headersStyle);
    final lastMonthLastDay =
    CalendarMonthlyUtils.getLastMonthLastDay(headersStyle);
    return SizedBox(
      height: 7 * 40,
      child: Directionality(
        textDirection: EventCalendar.calendarProvider.isRTL()
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 42,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, mainAxisExtent: 45, mainAxisSpacing: 5),
            itemBuilder: (context, index) {
              return _buildItem(
                  index, firstDayIndex, lastDayIndex, lastMonthLastDay);
            }),
      ),
    );
  }

  _buildItem(int index, int firstDayIndex, int lastDayIndex,
      int lastMonthLastDay) {
    int day = -1;

    final isCurrentMonthDays = index >= firstDayIndex && index < lastDayIndex;
    final isNextMonthDays = index >= lastDayIndex;

    if (isCurrentMonthDays)
      day = index - firstDayIndex + 1;
    else if (isNextMonthDays)
      day = index - lastDayIndex + 1;
    else
      day = lastMonthLastDay - (firstDayIndex - index) + 1;

    if (isCurrentMonthDays) {
      return buildCurrentMonthDay(day);
    } else if (isNextMonthDays) {
      return buildNextMonthDay(day);
    } else if (day > 0) {
      return buildPrevMonthDay(day);
    }
    return SizedBox();
  }


  Widget rangeSelectionHighlightPainter(int day, List list) {
    HighlightPainter highlightPainterStart = HighlightPainter(
      color: Colors.blue,
      style: HighlightPainterStyle.highlightTrailing,
    );
    HighlightPainter highlightPainterEnd = HighlightPainter(
      color: Colors.blue,
      style: HighlightPainterStyle.highlightLeading,
    );
    HighlightPainter highlightPainterRange = HighlightPainter(
      color: Colors.blue,
      style: HighlightPainterStyle.highlightAll,
    );


    if (selectedDayStart.day == day && selectedDayStart.month == currMonth &&
        selectedDayStart.year == currYear)
      return CustomPaint(
        painter: highlightPainterStart,
      );

    if (selectedDayEnd.day == day && selectedDayEnd.month == currMonth &&
        selectedDayEnd.year == currYear)
      return CustomPaint(
        painter: highlightPainterEnd,
      );


    for (int i = 1; i < list.length; i++) {
      if (list[i].day == day && list[i].month == currMonth &&
          list[i].year == currYear)
        return CustomPaint(
          painter: highlightPainterRange,
        );
    }


    return SizedBox();
  }

  buildCurrentMonthDay(day) {
    final CalendarDateTime? specialDay = CalendarUtils.getFromSpecialDay(
        widget.specialDays, currYear, currMonth, day);

    BoxDecoration? decoration = StyleProvider.getSpecialDayDecoration(
        specialDay, currYear, currMonth, day);

    return Stack(
      fit: StackFit.passthrough,
      children: [
        (widget.multiSelection && selectedDaysRange.length >= 2) ?
        rangeSelectionHighlightPainter(day, selectedDaysRange)
            : Container(),

        Day(
          dayEvents: eventSelector.getEventsByDayMonthYear(
            CalendarDateTime(
              year: currYear,
              month: currMonth,
              day: day,
              calendarType: CalendarUtils.getCalendarType(),
            ),
          ),
          day: day,
          weekDay: '',
          dayStyle: DayStyle(
              compactMode: DayOptions
                  .of(context)
                  .compactMode,
              enabled: specialDay?.isEnableDay ?? true,
              selected: checkSelected(day),
              useUnselectedEffect: false,
              decoration: decoration),
          onCalendarChanged: () {
            CalendarUtils.goToDay(day);
            changeDay();
            widget.onCalendarChanged.call();
          },
        ),
      ],
    );
  }

  buildNextMonthDay(int day) {
    final year = CalendarMonthlyUtils.getYear(currMonth + 1);
    final month = CalendarMonthlyUtils.getMonth(currMonth + 1);

    final CalendarDateTime? specialDay =
    CalendarUtils.getFromSpecialDay(widget.specialDays, year, month, day);

    BoxDecoration? decoration =
    StyleProvider.getSpecialDayDecoration(specialDay, year, month, day);

    return Day(
      day: day,
      weekDay: '',
      dayEvents: eventSelector.getEventsByDayMonthYear(
        CalendarDateTime(
            year: year,
            month: month,
            day: day,
            calendarType: CalendarUtils.getCalendarType()),
      ),
      dayStyle: DayStyle(
        compactMode: DayOptions
            .of(context)
            .compactMode,
        enabled: specialDay?.isEnableDay ?? true,
        decoration: decoration,
        selected: false,
        useUnselectedEffect: true,
      ),
      onCalendarChanged: () {
        // reset to first to fix switching between 31/30/29 month lengths
        CalendarUtils.nextMonth();
        CalendarUtils.goToDay(day);
        changeDay();
        widget.onCalendarChanged.call();
      },
    );
  }

  buildPrevMonthDay(int day) {
    final year = CalendarMonthlyUtils.getYear(currMonth - 1);
    final month = CalendarMonthlyUtils.getMonth(currMonth - 1);

    final CalendarDateTime? specialDay =
    CalendarUtils.getFromSpecialDay(widget.specialDays, year, month, day);

    BoxDecoration? decoration =
    StyleProvider.getSpecialDayDecoration(specialDay, year, month, day);

    return Day(
      day: day,
      dayEvents: eventSelector.getEventsByDayMonthYear(CalendarDateTime(
          year: year,
          month: month,
          day: day,
          calendarType: CalendarUtils.getCalendarType())),
      weekDay: '',
      dayStyle: DayStyle(
        compactMode: true,
        enabled: specialDay?.isEnableDay ?? true,
        selected: false,
        decoration: decoration,
        useUnselectedEffect: true,
      ),
      onCalendarChanged: () {
        // reset to first to fix switching between 31/30/29 month lengths
        CalendarUtils.previousMonth();
        CalendarUtils.goToDay(day);
        changeDay();
        widget.onCalendarChanged.call();
      },
    );
  }

  void _disableSelectedEnd() {
    selectedDayEnd.day = -1;
    selectedDayEnd.month = currMonth;
    selectedDayEnd.year = -1;
  }

  void selectedDayStartPointToSelectedDayEnd() {
    selectedDayStart.day = selectedDayEnd.day;
    selectedDayStart.month = selectedDayEnd.month;
    selectedDayStart.year = selectedDayEnd.year;
  }



  bool checkSelected(int day) {
    if (selectedDayEndAndSelectedDayStartAreInCurrentMonth()) {
      return (selectedDayEnd.day == day || selectedDayStart.day == day);
    }
    if (selectedDayStartIsInCurrentMonth()) {
      return (selectedDayStart.day == day);
    }
    else if (selectedDayEndIsInCurrentMonth()) {
      return selectedDayEnd.day == day;
    }
    else {
      return false;
    }
  }
  bool selectedDayEndAndSelectedDayStartAreInCurrentMonth(){
    late bool result;
    (selectedDayEnd.month == currMonth &&
        selectedDayStart.month == currMonth && selectedDayStart.year == currYear && selectedDayEnd.year == currYear)?result=true:result=false;
    return result;
  }
  bool selectedDayStartIsInCurrentMonth(){
    late bool result;
    (selectedDayStart.month == currMonth &&
        selectedDayStart.year == currYear)?result=true:result=false;
    return result;
  }
  bool selectedDayEndIsInCurrentMonth(){
    late bool result;
    (selectedDayEnd.month == currMonth && selectedDayEnd.year == currYear)?result=true:result=false;
    return result;
  }
}









