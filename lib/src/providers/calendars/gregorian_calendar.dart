import '../../../flutter_event_calendar.dart';
import '../../handlers/translator.dart';
import 'calendar_provider.dart';

class GregorianCalendar extends CalendarProvider {
  @override
  CalendarDateTime getDateTime() {
    return CalendarDateTime.parseDateTime(DateTime.now().toString(), getCalendarType())!;
  }

  @override
  CalendarDateTime getNextMonthDateTime() {
    final date = _getSelectedDate();
    return CalendarDateTime.parseDateTime(DateTime(date.year, date.month + 1, 1).toString(), getCalendarType())!;
  }

  @override
  CalendarDateTime getPreviousMonthDateTime() {
    final date = _getSelectedDate();
    return CalendarDateTime.parseDateTime(DateTime(date.year, date.month - 1, 1).toString(), getCalendarType())!;
  }

  @override
  CalendarDateTime getPreviousDayDateTime() {
    final date = _getSelectedDate();
    return CalendarDateTime(year: date.year, month: date.month, day: date.day - 1, calendarType: getCalendarType());
  }

  @override
  CalendarDateTime getNextDayDateTime() {
    final date = _getSelectedDate();
    return CalendarDateTime(year: date.year, month: date.month, day: date.day + 1, calendarType: getCalendarType());
  }

  @override
  bool isRTL() => Translator.isRTL();

  @override
  Map getMonthDays(WeekDayStringTypes type, int index) {
    Map days = {};
    CalendarDateTime now = _getSelectedDate();
    int monthLength = DateTime(now.year, index + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(now.year, index, 1);
    int dayIndex = firstDayOfMonth.weekday;

    switch (type) {
      case WeekDayStringTypes.FULL:
        for (var i = 1; i <= monthLength; i++) {
          days[i] = Translator.getFullNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
      case WeekDayStringTypes.SHORT:
        for (var i = 1; i <= monthLength; i++) {
          days[i] = Translator.getShortNameOfDays()[dayIndex % 7];
          dayIndex++;
        }
        break;
    }
    return days;
  }

  @override
  Map getMonthDaysShort(int index) {
    Map days = {};
    CalendarDateTime now = _getSelectedDate();
    int monthLength = DateTime(now.year, index + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(now.year, index, 1);
    int dayIndex = firstDayOfMonth.weekday;
    for (var i = 1; i <= monthLength; i++) {
      days[i] = Translator.getShortNameOfDays()[dayIndex % 7];
      dayIndex++;
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
    int daysinCurrentMonth=getMonthDays(WeekDayStringTypes.FULL, month).length;
    List<int> days=[];
    for (var i = 1; i <= daysinCurrentMonth; i++) days.add(i);
    return days;
  }
  CalendarDateTime _getSelectedDate() {
    return EventCalendar.dateTime!;
  }

  @override
  CalendarDateTime goToDay(index) {
    dynamic date = _getSelectedDate();
    return CalendarDateTime(year: date.year, month: date.month, day: index, calendarType: getCalendarType());
  }

  @override
  CalendarDateTime goToMonth(index) {
    dynamic date = _getSelectedDate();
    return CalendarDateTime(year: date.year, month: index, day: 1, calendarType: getCalendarType());
  }

  @override
  CalendarDateTime goToYear(index) {
    dynamic date = _getSelectedDate();
    return CalendarDateTime(year: index, month: date.month, day: 1, calendarType: getCalendarType());
  }

  @override
  int getDateTimePart(PartFormat format) {
    CalendarDateTime date = _getSelectedDate();
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
  String getFormattedDate({DateTime? customDate}) {
    CalendarDateTime? dateTime;
    if (customDate != null) {
      dateTime = CalendarDateTime.parseDateTime(customDate.toString(), getCalendarType());
    } else {
      dateTime = _getSelectedDate();
    }
    return "${dateTime!.day} ${Translator.getFullMonthNames()[dateTime.month - 1]} ${dateTime.year}";
  }

  @override
  CalendarType getCalendarType() {
    return CalendarType.GREGORIAN;
  }


}
