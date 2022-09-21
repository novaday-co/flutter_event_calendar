import 'package:flutter_event_calendar/flutter_event_calendar.dart';

class Fa {
  static Map fullMonthNames = const {
    'fa': {
      CalendarType.JALALI :[
          'فروردین',
          'اردیبهشت',
          'خرداد',
          'تیر',
          'مرداد',
          'شهریور',
          'مهر',
          'آبان',
          'آذر',
          'دی',
          'بهمن',
          'اسفند'
      ],
    CalendarType.GREGORIAN: [
        'ژانویه',
        'فوریه',
        'مارس',
        'آوریل',
        'مه',
        'ژوئن',
        'ژوئیه',
        'اوت',
        'سپتامبر',
        'اکتبر',
        'نوامبر',
        'دسامبر'
    ]
  }
};
  static Map shortMonthNames = const {
    'fa': { 
      CalendarType.JALALI : [
        'فرو',
        'ارد',
        'خرد',
        'تیر',
        'مرد',
        'شهر',
        'مهر',
        'آبا',
        'آذر',
        'دی',
        'بهم',
        'اسف'
    ],
      CalendarType.GREGORIAN: [
        'ژان',
        'قور',
        'مار',
        'آور',
        'مه',
        'ژوئ',
        'ژوئی',
        'اوت',
        'سپت',
        'اکت',
        'نوا',
        'دسا'
    ],
  } 
};
  static Map fullDayNames = const {
    'fa': {
      CalendarType.JALALI  : [
        'شنبه',
        'یکشنبه',
        'دوشنبه',
        'سه شنبه',
        'چهارشنبه',
        'پنج شنبه',
        'جمعه'
    ],
      CalendarType.GREGORIAN: [
        'یکشنبه',
        'دوشنبه',
        'سه شنبه',
        'چهارشنبه',
        'پنجشنبه',
        'جمعه',
        'شنبه'
    ],
  }
};
  static Map shortDayNames = const {
    'fa': { 
      CalendarType.JALALI : ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'],
      CalendarType.GREGORIAN: ['ی', 'د', 'س', 'چ', 'پ', 'ج', 'ش']
    }
  };
  static Map titles = const {
    'fa': {
      'empty': 'خالی',
      'month_selector': 'یک ماه را انتخاب کنید',
      'year_selector': 'یک سال را انتخاب کنید',
    }
  };

  static Map directionIsRTL = {'fa': true};
}
