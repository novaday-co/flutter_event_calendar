import 'package:flutter_event_calendar/flutter_event_calendar.dart';

class Fa {
  static Map fullMonthNames = const {
    'fa': {
      CalendarType.Jalali :[
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
    CalendarType.Gregorian: [
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
      CalendarType.Jalali : [
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
      CalendarType.Gregorian: [
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
      CalendarType.Jalali  : [
        'شنبه',
        'یکشنبه',
        'دوشنبه',
        'سه شنبه',
        'چهارشنبه',
        'پنج شنبه',
        'جمعه'
    ],
      CalendarType.Gregorian: [
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
      CalendarType.Jalali : ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'], 
      CalendarType.Gregorian: ['ی', 'د', 'س', 'چ', 'پ', 'ج', 'ش'] 
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
