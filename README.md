<p align="center">
<img src="https://raw.githubusercontent.com/faridfr/flutter_event_calendar/master/assets/flutter_event_calendar_header.png" height="400" alt="flutter Event Calendar Package" />
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
  flutter_event_calendar: ^0.0.3
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

## Basic Usage :

You can load a full calendar with events .

```dart
  return EventCalendar(
        events: [
          Event(
            title: 'Laravel Event',
            description: 'The largest Laravel event of the year ...',
            dateTime: '2020-09-27 20:00',
          ),
        ],
      ),
```


## Options :

<p align="center">
<img src="https://raw.githubusercontent.com/faridfr/flutter_event_calendar/master/assets/event_calendar_options.png" height="400" alt="flutter Event Calendar Package" />
</p>


You have many option for changes in : style , locale and structure.


| Option       	| Type                         	|
|------------	|-------------------------------------	|
| type 	| String ( jalali or gregorian )	|
| dateTime 	| String ( yy-mm-dd H:i:s )	|
| events	 	| List<Event> 	|
| font	 	| String 	|
| headerMonthStringType	 	| String 	|
| headerWeekDayStringType	 	| String 	|
| weekDaySelectedColor	 	| Color 	|
| weekDayUnselectedColor	 	| Color 	|
| dayIndexSelectedBackgroundColor	 	| Color 	|
| dayIndexUnselectedBackgroundColor	 	| Color 	|
| dayIndexSelectedForegroundColor	 	| Color 	|
| dayIndexUnelectedForegroundColor	 	| Color	|
| emptyText	 	| String	|
| emptyTextColor	 	| Color	|
| emptyIcon	 	| IconData	|
| emptyIconColor	 	| Color	|
| eventBackgroundColor	 	| Color	|
| eventTitleColor	 	| Color	|
| eventDescriptionColor	 	| Color	|
| eventDateTimeColor	 	| Color	|
| isRTL	 	| bool	|


## Event Structure


| Option       	| Type                         	|
|------------	|-------------------------------------	|
| title 	| String	|
| description 	| String 	|
| dateTime	 	| String ( yy-mm-dd H:i:s ) 	|
| onTap	 	| Function 	|
| onLongPress	 	| Function 	|

## Locales :

**Event Calendar** supports two types of calendar now . **Gregorian** , and **Jalali** . Whenevenr you change **type** , package change **direction** and **language** automatically.


## Contribute :
You can help me and contribute for :
- New options
- More locales
- Better exceptions
