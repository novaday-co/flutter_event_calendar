import 'package:flutter_event_calendar/flutter_event_calendar.dart';

class En{
  static Map fullMonthNames = const {
    'en': {
      CalendarType.Jalali: [
        'Farvardin',
        'Ordibehesht',
        'Khordad',
        'Tir',
        'Mordad',
        'Shahrivar',
        'Mehr',
        'Aban',
        'Azar',
        'Dey',
        'Bahman',
        'Esfand'
    ],
      CalendarType.Gregorian: [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ]
    }
  };
  static Map shortMonthNames = const {
  'en': {
    CalendarType.Jalali: [
      'Far',
      'Ord',
      'Kho',
      'Tir',
      'Mor',
      'Sha',
      'Mehr',
      'Aban',
      'Azar',
      'Dey',
      'Bah',
      'Esf'
    ],
    CalendarType.Gregorian: [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ]
  }
};

  static Map fullDayNames = const {
    'en': {
      CalendarType.Jalali: [
        'Saturday',
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
    ],
    CalendarType.Gregorian: [
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday'
    ]
  }
};
  static Map shortDayNames = const {
    'en': {
      CalendarType.Jalali: ['Sa', 'Su', 'Mo', 'Tu', 'We', 'Th', 'Fr'],
      CalendarType.Gregorian: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
    }
  };
  static Map titles = const {
    'en': {
      'empty': 'Empty',
      'month_selector': 'Choose a month',
      'year_selector': 'Choose a year',
    }
  };

  static Map directionIsRTL = { 'en' : false };
}