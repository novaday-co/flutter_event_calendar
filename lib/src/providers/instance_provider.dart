import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/providers/calendars/calendar_provider.dart';
import 'package:flutter_event_calendar/src/providers/calendars/gregorian_calendar.dart';
import 'package:flutter_event_calendar/src/providers/calendars/jalali_calendar.dart';

CalendarProvider createInstance(CalendarType cType) {
  final Map<CalendarType, CalendarProvider> _factories = {
    CalendarType.JALALI: JalaliCalendar(),
    CalendarType.GREGORIAN: GregorianCalendar()
  };
  if (!_factories.keys.contains(cType)) {
    throw Exception(
        "Cannot create instance of calendar, check available calendar types or create your own calendar that implements BaseCalendarProvider");
  }

  return _factories[cType]!;
}
