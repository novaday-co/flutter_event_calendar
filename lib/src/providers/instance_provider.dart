import 'package:flutter_event_calendar/src/providers/calendares/base_calendar_provider.dart';
import 'package:flutter_event_calendar/src/providers/calendares/fa_calendar.dart';

final Map<String, BaseCalendarProvider> _factories = {'fa': FaCalendar()};

BaseCalendarProvider createInstance(String locale) {
  if (!_factories.keys.contains(locale)) {
    throw Exception(
        "Cannot create instance of calendar, check locale name or create a class that provides BaseCalendarProvider methods.");
  }

  return _factories[locale]!;
}
