class EventDateTime {
  int year;
  int month;
  int day;
  int? hour;
  int? minute;

  EventDateTime(
      {required this.year,
      required this.month,
      required this.day,
      this.hour,
      this.minute});

  //1400-9-12 20:00
  static EventDateTime parse(String dateTime) {
    final splitter = dateTime.split(" ");
    final datePart = splitter[0].split("-");
    final timePart = splitter[1].split(":");

    return EventDateTime(
        year: int.parse(datePart[0]),
        month: int.parse(datePart[1]),
        day: int.parse(datePart[2]),
        hour: int.parse(timePart[0]),
        minute: int.parse(timePart[1]));
  }

  bool isDateEqual(EventDateTime dateTime) {
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day;
  }

  bool isDateTimeEqual(EventDateTime dateTime) {
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day &&
        hour == dateTime.hour &&
        minute == dateTime.minute;
  }

  @override
  String toString() {
    // TODO: implement toString
    if (hour != null && minute != null) {
      return "$year/$month/$day $hour:$minute";
    } else
      return "$year/$month/$day";
  }
}
