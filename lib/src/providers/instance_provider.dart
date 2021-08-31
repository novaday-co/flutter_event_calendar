import 'package:flutter_event_calendar/src/providers/calendares/base_calendar_provider.dart';
import 'package:flutter_event_calendar/src/providers/calendares/en_calendar.dart';
import 'package:flutter_event_calendar/src/providers/calendares/fa_calendar.dart';

BaseCalendarProvider createInstance(String locale) {
  final Map<String, BaseCalendarProvider> _factories = {
    'fa': FaCalendar(),
    'en': EnCalendar()
  };
  if (!_factories.keys.contains(locale)) {
    throw Exception(
        "Cannot create instance of calendar, check locale name or create a class that provides BaseCalendarProvider methods.");
  }

  return _factories[locale]!;
}
