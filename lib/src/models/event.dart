import 'package:flutter_event_calendar/flutter_event_calendar.dart';

class Event {
  late int listIndex;
  late String title;
  late String description;
  late EventDateTime dateTime;
  late Function? onTap;
  late Function? onLongPress;

  Event({
    required this.title,
    String? description,
    required this.dateTime,
    onTap(int listIndex)?,
    onLongPress,
  }) {
    this.description = description ?? '';
    this.onTap = onTap;
    this.onLongPress = onLongPress ??
        (int listIndex) {
          print('LongPress ' + listIndex.toString());
        };
  }
}
