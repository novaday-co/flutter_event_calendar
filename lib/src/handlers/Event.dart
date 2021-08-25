class Event {
  late int listIndex;
  late String title;
  late String description;
  late String dateTime;
  late Function onTap;
  late Function onLongPress;

  Event({
    title,
    description,
    dateTime,
    onTap(int listIndex)?,
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
