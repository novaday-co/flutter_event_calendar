import 'package:flutter_event_calendar/src/providers/calendares/calendar_provider.dart';
import 'package:flutter_event_calendar/src/providers/calendares/en_calendar.dart';
import 'package:flutter_event_calendar/src/providers/calendares/fa_calendar.dart';

CalendarProvider createInstance(String locale) {
  final Map<String, CalendarProvider> _factories = {
    'fa': FaCalendar(),
    'en': EnCalendar()
  };
  if (!_factories.keys.contains(locale)) {
    throw Exception(
        "Cannot create instance of calendar, check locale name or create a class that implements BaseCalendarProvider");
  }

  return _factories[locale]!;
}
