import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/handlers/EventSelector.dart';

class CalendarMonth extends StatelessWidget {
  CalendarMonth({Key? key}) : super(key: key);
  final dayNames = CalendarSelector().getDayNames();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_buildDayName(), _buildMonthView()],
    );
  }

  _buildDayName() {
    return Row(
      children: List.generate(
        7,
        (index) => Expanded(
          child: Center(
            child: Text(
              dayNames[index],
              style: TextStyle(fontFamily: EventCalendar.font),
            ),
          ),
        ),
      ),
    );
  }

  _buildMonthView() {
    final monthDays = CalendarSelector().getDays();
    final firstDayIndex = getFirstDayOfMonth();
    final lastDayIndex = firstDayIndex + getLastDayOfMonth();
    return SizedBox(
      height: 200,
      child: GridView.builder(
        itemCount: 35,

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, childAspectRatio: 1.5),
        itemBuilder: (context, index) {
          if(index >= firstDayIndex && index< lastDayIndex )
            return Center(child: Text("${index - firstDayIndex + 1}"),);
          return Center(child: Text("NaN"));
        },
      ),
    );
  }
  getFirstDayOfMonth(){
    final monthDays = CalendarSelector().getDays();
    print("index of ${dayNames.indexOf(monthDays[1])}");
    return dayNames.indexOf(monthDays[1]);
  }

  getLastDayOfMonth() {
    return CalendarSelector().getDays().keys.last;
  }
}
