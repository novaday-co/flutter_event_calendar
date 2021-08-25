import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'Translator.dart';

class CalendarSelector {
  goToYear(index) {
    dynamic date = getSelectedDate();
    switch (EventCalendar.type) {
      case 'jalali':
        final f = date.formatter;
        EventCalendar.dateTime = '$index-${f.mm}-01';
        break;
      case 'gregorian':
        dynamic newDate = DateTime(index, date.month, 1);
        EventCalendar.dateTime = newDate.toString();
        break;
    }
  }

  goToMonth(index) {
    dynamic date = getSelectedDate();
    switch (EventCalendar.type) {
      case 'jalali':
        final f = date.formatter;
        EventCalendar.dateTime = '${f.y}-$index-01';
        break;
      case 'gregorian':
        dynamic newDate = DateTime(date.year, index, 1);
        EventCalendar.dateTime = newDate.toString();
        break;
    }
  }

  goToDay(index) {
    dynamic date = getSelectedDate();
    switch (EventCalendar.type) {
      case 'jalali':
        index = index < 10 ? '0$index' : index;
        final f = date.formatter;
        EventCalendar.dateTime = '${f.y}-${f.mm}-$index';
        break;
      case 'gregorian':
        dynamic newDate = DateTime(date.year, date.month, index);
        EventCalendar.dateTime = newDate.toString();
        break;
    }
  }

  nextDay() {
    dynamic date = getSelectedDate();
    switch (EventCalendar.type) {
      case 'jalali':
        dynamic newDate = date.addDays(1);
        final f = newDate.formatter;
        EventCalendar.dateTime = '${f.y}-${f.mm}-${f.dd}';
        break;
      case 'gregorian':
        dynamic newDate = DateTime(date.year, date.month, date.day + 1);
        EventCalendar.dateTime = newDate.toString();
        break;
    }
  }

  previousDay() {
    dynamic date = getSelectedDate();
    switch (EventCalendar.type) {
      case 'jalali':
        dynamic newDate = date.addDays(-1);
        final f = newDate.formatter;
        EventCalendar.dateTime = '${f.y}-${f.mm}-${f.dd}';
        break;
      case 'gregorian':
        dynamic newDate = DateTime(date.year, date.month, date.day - 1);
        EventCalendar.dateTime = newDate.toString();
        break;
    }
  }

  nextMonth() {
    dynamic date = getSelectedDate();
    switch (EventCalendar.type) {
      case 'jalali':
        dynamic newDate = date.addMonths(1);
        final f = newDate.formatter;
        EventCalendar.dateTime = '${f.y}-${f.mm}-01';
        break;
      case 'gregorian':
        dynamic newDate = DateTime(date.year, date.month + 1, 1);
        EventCalendar.dateTime = newDate.toString();
        break;
    }
  }

  previousMonth() {
    dynamic date = getSelectedDate();
    switch (EventCalendar.type) {
      case 'jalali':
        dynamic newDate = date.addMonths(-1);
        final f = newDate.formatter;
        EventCalendar.dateTime = '${f.y}-${f.mm}-01';
        break;
      case 'gregorian':
        dynamic newDate = DateTime(date.year, date.month - 1, 1);
        EventCalendar.dateTime = newDate.toString();
        break;
    }
  }

  List getMonths() {
    return Translator().getMonthNames();
  }

  List getYears() {
    switch (EventCalendar.type) {
      case 'jalali':
        return getJalaliYearsList();
      case 'gregorian':
        return getGregorianYearsList();
      default:
        return [];
    }
  }

  Map getDays() {
    switch (EventCalendar.type) {
      case 'jalali':
        return getJalaliDaysList();
      case 'gregorian':
        return getGregorianDaysList();
      default:
        return {};
    }
  }

  ///////////////////////////////////////////////////
  ///////////////// helper functions ////////////////
  ///////////////////////////////////////////////////

  List getJalaliYearsList() {
    int year = getSelectedJalaliDate().year;
    List years = [];
    for (var i = -100; i <= 50; i++) years.add(year + i);
    return years;
  }

  List getGregorianYearsList() {
    int year = getSelectedGregorianDate().year;
    List years = [];
    for (var i = -100; i <= 50; i++) years.add(year + i);
    return years;
  }

  Map getJalaliDaysList() {
    Map days = {};
    Jalali firstDayOfMonth = getSelectedJalaliDate().withDay(1);
    int dayIndex = firstDayOfMonth.weekDay - 1;
    for (var i = 1; i <= firstDayOfMonth.monthLength; i++) {
      days[i] = Translator().getWeekDayNameWithIndex(dayIndex % 7);
      dayIndex++;
    }
    return days;
  }

  Map getGregorianDaysList() {
    Map days = {};
    DateTime now = getSelectedGregorianDate();
    int monthLength = DateTime(now.year, now.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    int dayIndex = firstDayOfMonth.weekday;
    for (var i = 1; i <= monthLength; i++) {
      days[i] = Translator().getWeekDayNameWithIndex(dayIndex % 7);
      dayIndex++;
    }
    return days;
  }

  getSelectedDate() {
    switch (EventCalendar.type) {
      case 'jalali':
        return getSelectedJalaliDate();
      case 'gregorian':
        return getSelectedGregorianDate();
    }
  }

  getSelectedJalaliDate() {
    try {
      List dateTimeParts = EventCalendar.dateTime.split(' ');
      List dateParts = dateTimeParts[0].split('-');
      Jalali jv = Jalali(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
      );
      return jv;
    } on DateException catch (e) {
      print(e);
    }
  }

  getSelectedGregorianDate() {
    return DateTime.parse(EventCalendar.dateTime);
  }

  getPart({required String format,required String responseType}) {
    switch (EventCalendar.type) {
      case 'jalali':
        return responseType == 'int'
            ? getJalaliPart(format)
            : Translator().getPartTranslate(format, getJalaliPart(format) - 1);
      case 'gregorian':
        return responseType == 'int'
            ? getGregorianPart(format)
            : Translator().getPartTranslate(format, getJalaliPart(format) - 1);
    }
  }

  getJalaliPart(String format) {
    Jalali date = getSelectedJalaliDate();
    switch (format) {
      case 'year':
        return date.year;
      case 'month':
        return date.month;
      case 'day':
        return date.day;
    }
  }

  getGregorianPart(String format) {
    DateTime date = getSelectedGregorianDate();
    switch (format) {
      case 'year':
        return date.year;
      case 'month':
        return date.month;
      case 'day':
        return date.day;
    }
  }
}
