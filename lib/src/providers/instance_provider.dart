import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/providers/calendares/calendar_provider.dart';
import 'package:flutter_event_calendar/src/providers/calendares/en_calendar.dart';
import 'package:flutter_event_calendar/src/providers/calendares/fa_calendar.dart';

CalendarProvider createInstance(CalendarType cType) {
  final Map<CalendarType, CalendarProvider> _factories = {
    CalendarType.Jalali: FaCalendar(),
    CalendarType.Gregorian: EnCalendar()
  };
  if (!_factories.keys.contains(cType)) {
    throw Exception(
        "Cannot create instance of calendar, check available calendar types or create your own calendar that implements BaseCalendarProvider");
  }

  return _factories[cType]!;
}
