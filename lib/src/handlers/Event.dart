class Event {
  int listIndex;
  String title;
  String description;
  String dateTime;
  Function onTap;
  Function onLongPress;

  Event({
    title,
    description,
    dateTime,
    onTap(int listIndex),
    onLongPress,
  }) {
    this.title = title ?? '';
    this.description = description ?? '';
    this.dateTime = dateTime ?? '';
    this.onTap = onTap ??
        (int listIndex) {
          print('Tap ' + listIndex.toString());
        };
    this.onLongPress = onLongPress ??
        (int listIndex) {
          print('LongPress ' + listIndex.toString());
        };
  }
}
