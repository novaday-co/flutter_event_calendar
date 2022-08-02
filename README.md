<p align="center">
<img src="https://raw.githubusercontent.com/novaday-co/flutter_event_calendar/master/assets/flutter_event_calendar.png" height="400" alt="flutter Event Calendar Package" />
</p>

<p align="center">
<a href="https://pub.dev/packages/flutter_event_calendar"><img src="https://img.shields.io/pub/v/flutter_event_calendar.svg" alt="Pub"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
</p>


---


# Event Calendar

## How to install :

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  flutter_event_calendar: ^0.0.8
```

Then You can install packages from the command line:
```yaml
$ pub get
```

or

```yaml
$ flutter pub get
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

Now in your Dart code, you can use:

```dart
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
```
<p align="center">
<img src="https://raw.githubusercontent.com/novaday-co/flutter_event_calendar/master/assets/event_calendar_options.png" height="600" alt="flutter Event Calendar Package" />
<br></p>

## Basic Usage :

You can load a full calendar with events .

```dart
  return EventCalendar(
calendarType: CalendarType.JALALI,
calendarLanguage: 'fa',
events: [
Event(
child: const Text('Laravel Event'),
dateTime: CalendarDateTime(
year: 1401,
month: 5,
day: 12,
calendarType: CalendarType.JALALI),
),
],
)
```


<p align="center">
<img src="https://raw.githubusercontent.com/novaday-co/flutter_event_calendar/master/assets/eventCalendar.gif" height="600" alt="flutter Event Calendar Package" />
<br></p>

## Options :

You have many option for changes in : style , locale and structure.


| Option       	| Type                         	|
|------------	|-------------------------------------	|
| calendarType 	| CalendarType ( JALALI or GREGORIAN )	|
| middleWidget 	| Widget	|
| events	 	| List<Event> 	|
| calendarOptions	 	| CalendarOptions 	|
| headerOptions	 	| HeaderOptions 	|
| eventOptions	 	| EventOptions 	|
| dayOptions	 	| DayOptions 	|
| showLoadingForEvent	 	| bool 	|
| specialDays	 	| List<CalendarDateTime> 	|
| onChangeDateTime	 	| Function(CalendarDateTime) 	|
| onMonthChanged	 	| Function(CalendarDateTime) 	|
| onDateTimeReset	 	| Function(CalendarDateTime) 	|
| onInit	 	| Function 	|
| onYearChanged	 	| Function(CalendarDateTime) 	|
| calendarLanguage	 	| String(fa or en) 	|

## CalendarOptions :

| Option       	| Type                         	|
|------------	|-------------------------------------	|
| toggleViewType 	| bool	|
| viewType 	| ViewType	|
| font	 	| String 	|
| headerMonthBackColor	 	| Color 	|
| headerMonthShadowColor	 	| Color 	|
| headerMonthElevation	 	| double 	|
| headerMonthShape	 	| ShapeBorder 	|

### HeaderOptions :

| Option       	| Type                         	|
|------------	|-------------------------------------	|
| weekDayStringType 	| WeekDayStringTypes(FULL or SHORT)	|
| MonthStringTypes 	| MonthStringTypes(FULL or SHORT)	|
| headerTextColor	 	| Color 	|
| navigationColor	 	| Color 	|
| resetDateColor	 	| Color 	|

### EventOptions :

| Option       	| Type                         	|
|------------	|-------------------------------------	|
| emptyText 	| String	|
| emptyTextColor	 	| Color 	|
| emptyIcon	 	| IconData 	|
| emptyIconColor	 	| Color 	|


### DayOptions :

| Option       	| Type                         	|
|------------	|-------------------------------------	|
| weekDaySelectedColor	 	| Color 	|
| weekDayUnselectedColor	 	| Color 	|
| showWeekDay	 	| bool 	|
| mini	 	| bool 	|
| selectedBackgroundColor	 	| Color 	|
| unselectedBackgroundColor	 	| Color 	|
| selectedTextColor	 	| Color 	|
| disabledTextColor	 	| Color 	|
| unselectedTextColor	 	| Color 	|
| eventCounterColor	 	| Color 	|
| eventCounterViewType	 	| DayEventCounterViewType 	|
| eventCounterTextColor	 	| Color 	|
| disableFadeEffect	 	| bool 	|
| disableDaysBeforeNow	 	| bool 	|


### Event Structure


| Option       	| Type                         	|
|------------	|-------------------------------------	|
| child 	| Widget	|
| dateTime	 	| CalendarDateTime 	|
| onTap	 	| Function 	|
| onLongPress	 	| Function 	|

## Locales :

**Event Calendar** supports two types of calendar now . **Gregorian** , and **Jalali** . Whenevenr you change **type** , package change **direction** and **language** automatically.


## Contribute :
You can help me and contribute for :
- New options
- More locales
- Better exceptions
