import 'package:shamsi_date/shamsi_date.dart';

import '../../../flutter_event_calendar.dart';
import '../../handlers/translator.dart';
import 'calendar_provider.dart';

class JalaliCalendar extends CalendarProvider {
  @override
  CalendarDateTime getDateTime() {
    final f = Jalali.now().formatter;

    return CalendarDateTime(
        year: int.parse(f.yyyy), month: int.parse(f.mm), day: int.parse(f.dd), calendarType: getCalendarType());
  }

  @override
  CalendarDateTime getNextMonthDateTime() {
    final date = _getSelectedDate();
    final newDate = date.withDay(1).addMonths(1);
    final f = newDate.formatter;
    return CalendarDateTime(year: int.parse(f.y), month: int.parse(f.mm), day: 01, calendarType: getCalendarType());
  }

  @override
  CalendarDateTime getPreviousMonthDateTime() {
    final date = _getSelectedDate();
    dynamic newDate = date.withDay(1).addMonths(-1);
    final f = newDate.formatter;
    return CalendarDateTime(year: int.parse(f.y), month: int.parse(f.mm), day: 01, calendarType: getCalendarType());
  }

  @override
  CalendarDateTime getPreviousDayDateTime() {
    dynamic date = _getSelectedDate();
    dynamic newDate = date.addDays(-1);
    final f = newDate.formatter;
    return CalendarDateTime(
        year: int.parse(f.y), month: int.parse(f.mm), day: int.parse(f.dd), calendarType: getCalendarType());
  }

  @override
  CalendarDateTime getNextDayDateTime() {
    dynamic date = _getSelectedDate();
    dynamic newDate = date.addDays(1);
    final f = newDate.formatter;
    return CalendarDateTime(
        year: int.parse(f.y), month: int.parse(f.mm), day: int.parse(f.dd), calendarType: getCalendarType());
  }

  @override
  bool isRTL() => Translator.isRTL();

  @override
  Map getMonthDays(WeekDayStringTypes type, int index) {
    Map days = {};
    Jalali firstDayOfMonth = _getSelectedDate().withMonth(index).withDay(1);
    int dayIndex = firstDayOfMonth.weekDay - 1;
    switch (type) {
      case WeekDayStringTypes.FULL:
        for (var i = 1; i <= firstDayOfMonth.monthLength; i++) {
          days[i] = Translator.getFullNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
      case WeekDayStringTypes.SHORT:
        for (var i = 1; i <= firstDayOfMonth.monthLength; i++) {
          days[i] = Translator.getShortNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
    }
    return days;
  }

  @override
  List<int> getYears() {
    int year = _getSelectedDate().year;
    List<int> years = [];
    for (var i = -100; i <= 50; i++) years.add(year + i);
    return years;
  }
  @override
  List<int> getDayAmount() {
    int month=_getSelectedDate().month;
    int daysInCurrentMonth=getMonthDays(WeekDayStringTypes.FULL, month).length;
    List<int> days=[];
    for (var i = 1; i <= daysInCurrentMonth; i++) days.add(i);
    return days;
  }
  Jalali _getSelectedDate() {
    Jalali jv = Jalali(
      EventCalendar.dateTime!.year,
      EventCalendar.dateTime!.month,
      EventCalendar.dateTime!.day,
    );
    return jv;
  }

  @override
  CalendarDateTime goToDay(index) {
    dynamic date = _getSelectedDate();
    final f = date.formatter;
    return CalendarDateTime(year: int.parse(f.y), month: int.parse(f.mm), day: index, calendarType: getCalendarType());
  }

  @override
  CalendarDateTime goToMonth(index) {
    dynamic date = _getSelectedDate();
    final f = date.formatter;
    return CalendarDateTime(year: int.parse(f.y), month: index, day: 01, calendarType: getCalendarType());
  }

  @override
  CalendarDateTime goToYear(index) {
    dynamic date = _getSelectedDate();
    final f = date.formatter;
    return CalendarDateTime(year: index, month: int.parse(f.mm), day: 01, calendarType: getCalendarType());
  }

  @override
  int getDateTimePart(PartFormat format) {
    Jalali date = _getSelectedDate();
    switch (format) {
      case PartFormat.YEAR:
        return date.year;
      case PartFormat.MONTH:
        return date.month;
      case PartFormat.DAY:
        return date.day;
    }
  }

  @override
  Map getMonthDaysShort(int index) {
    Map days = {};
    Jalali firstDayOfMonth = _getSelectedDate().withMonth(index).withDay(1);
    int dayIndex = firstDayOfMonth.weekDay - 1;
    for (var i = 1; i <= firstDayOfMonth.monthLength; i++) {
      days[i] = Translator.getShortNameOfDays()[dayIndex % 7];
      dayIndex++;

    }
    return days;
  }

  @override
  String getFormattedDate({DateTime? customDate}) {
    Jalali? dateTime;
    if (customDate != null) {
      dateTime = Jalali.fromDateTime(customDate);
    } else {
      dateTime = _getSelectedDate();
    }
    return "${dateTime.day} ${Translator.getFullMonthNames()[dateTime.month - 1]} ${dateTime.year}";
  }

  @override
  CalendarType getCalendarType() {
    return CalendarType.JALALI;
  }


}
