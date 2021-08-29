import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/utils/types/calendar_types.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'Translator.dart';

class CalendarSelector {
  goToYear(index) {
    EventCalendar.dateTime = EventCalendar.calendarProvider.goToMonth(index);
    // dynamic date = getSelectedDate();
    // switch (EventCalendar.type) {
    //   case CalendarType.Jalali:
    //     final f = date.formatter;
    //     EventCalendar.dateTime = '$index-${f.mm}-01';
    //     break;
    //   case CalendarType.Gregorian:
    //     dynamic newDate = DateTime(index, date.month, 1);
    //     EventCalendar.dateTime = newDate.toString();
    //     break;
    // }
  }

  goToMonth(index) {
    EventCalendar.dateTime = EventCalendar.calendarProvider.goToMonth(index);
    // dynamic date = getSelectedDate();
    // switch (EventCalendar.type) {
    //   case CalendarType.Jalali:
    //     final f = date.formatter;
    //     EventCalendar.dateTime = '${f.y}-$index-01';
    //     break;
    //   case CalendarType.Gregorian:
    //     dynamic newDate = DateTime(date.year, index, 1);
    //     EventCalendar.dateTime = newDate.toString();
    //     break;
    // }
  }

  goToDay(index) {
    EventCalendar.dateTime = EventCalendar.calendarProvider.goToDay(index);
    // dynamic date = getSelectedDate();
    // switch (EventCalendar.type) {
    //   case CalendarType.Jalali:
    //     index = index < 10 ? '0$index' : index;
    //     final f = date.formatter;
    //     EventCalendar.dateTime = '${f.y}-${f.mm}-$index';
    //     break;
    //   case CalendarType.Gregorian:
    //     dynamic newDate = DateTime(date.year, date.month, index);
    //     EventCalendar.dateTime = newDate.toString();
    //     break;
    // }
  }

  nextDay() {
    EventCalendar.dateTime =
        EventCalendar.calendarProvider.getNextDayDateTime();
  }

  previousDay() {
    EventCalendar.dateTime =
        EventCalendar.calendarProvider.getPreviousDayDateTime();
  }

  nextMonth() {
    EventCalendar.dateTime =
        EventCalendar.calendarProvider.getNextMonthDateTime();
    // dynamic date = getSelectedDate();
    // switch (EventCalendar.type) {
    //   case CalendarType.Jalali:
    //     dynamic newDate = date.addMonths(1);
    //     final f = newDate.formatter;
    //     EventCalendar.dateTime = '${f.y}-${f.mm}-01';
    //     break;
    //   case CalendarType.Gregorian:
    //     dynamic newDate = DateTime(date.year, date.month + 1, 1);
    //     EventCalendar.dateTime = newDate.toString();
    //     break;
    // }
  }

  previousMonth() {
    EventCalendar.dateTime =
        EventCalendar.calendarProvider.getPreviousMonthDateTime();
    // dynamic date = getSelectedDate();
    // switch (EventCalendar.type) {
    //   case CalendarType.Jalali:
    //     dynamic newDate = date.addMonths(-1);
    //     final f = newDate.formatter;
    //     EventCalendar.dateTime = '${f.y}-${f.mm}-01';
    //     break;
    //   case CalendarType.Gregorian:
    //     dynamic newDate = DateTime(date.year, date.month - 1, 1);
    //     EventCalendar.dateTime = newDate.toString();
    //     break;
    // }
  }

  List getMonths() {
    return Translator().getMonthNames();
  }

  List getYears() => EventCalendar.calendarProvider.getYears();

  // switch (EventCalendar.type) {
  // case CalendarType.Jalali:
  // return getJalaliYearsList();
  // case CalendarType.Gregorian:
  // return getGregorianYearsList();
  // default:
  // return [];
  // }

  Map getDays() => EventCalendar.calendarProvider.getMonthDays();

  // {
  //   switch (EventCalendar.type) {
  //     case CalendarType.Jalali:
  //       return getJalaliDaysList();
  //     case CalendarType.Gregorian:
  //       return getGregorianDaysList();
  //     default:
  //       return {};
  //   }
  // }

  ///////////////////////////////////////////////////
  ///////////////// helper functions ////////////////
  ///////////////////////////////////////////////////

  // List getGregorianYearsList() {
  //   int year = getSelectedGregorianDate().year;
  //   List years = [];
  //   for (var i = -100; i <= 50; i++) years.add(year + i);
  //   return years;
  // }
  //
  // Map getGregorianDaysList() {
  //   Map days = {};
  //   DateTime now = getSelectedGregorianDate();
  //   int monthLength = DateTime(now.year, now.month + 1, 0).day;
  //   DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
  //   int dayIndex = firstDayOfMonth.weekday;
  //   for (var i = 1; i <= monthLength; i++) {
  //     days[i] = Translator().getWeekDayNameWithIndex(dayIndex % 7);
  //     dayIndex++;
  //   }
  //   return days;
  // }
  //
  // getSelectedDate() {
  //   switch (EventCalendar.type) {
  //     case CalendarType.Jalali:
  //       return getSelectedJalaliDate();
  //     case CalendarType.Gregorian:
  //       return getSelectedGregorianDate();
  //   }
  // }

  getSelectedGregorianDate() {
    return DateTime.parse(EventCalendar.dateTime);
  }

  getPart({required PartFormat format, required String responseType}) {
    if (responseType == 'int') {
      return EventCalendar.calendarProvider.getDateTimePart(format);
    } else {
      return Translator().getPartTranslate(
          format, EventCalendar.calendarProvider.getDateTimePart(format));
    }
    // switch (EventCalendar.type) {
    //   case CalendarType.Jalali:
    //     return responseType == 'int'
    //         ? getJalaliPart(format)
    //         : Translator().getPartTranslate(format, getJalaliPart(format) - 1);
    //   case CalendarType.Gregorian:
    //     return responseType == 'int'
    //         ? getGregorianPart(format)
    //         : Translator()
    //         .getPartTranslate(format, getGregorianPart(format) - 1);
    // }
  }

// getJalaliPart(String format) {
//   Jalali date = getSelectedJalaliDate();
//   switch (format) {
//     case 'year':
//       return date.year;
//     case 'month':
//       return date.month;
//     case 'day':
//       return date.day;
//   }
// }

// getGregorianPart(String format) {
//   DateTime date = getSelectedGregorianDate();
//   switch (format) {
//     case 'year':
//       return date.year;
//     case 'month':
//       return date.month;
//     case 'day':
//       return date.day;
//   }
// }
}
