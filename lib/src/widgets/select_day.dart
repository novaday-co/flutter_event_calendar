import 'package:flutter/material.dart';

import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:flutter_event_calendar/src/handlers/translator.dart';
import 'package:flutter_event_calendar/src/models/style/selected_day_options.dart';
import 'package:flutter_event_calendar/src/utils/calendar_types.dart';

class SelectDay extends StatelessWidget {
  late List days;

  Function(int day) onHeaderChanged;

  DayOptions? dayStyle;

  SelectDay({required this.onHeaderChanged, this.dayStyle});

  ScrollController _scrollController = ScrollController();

  late VoidCallback scrollToPositionCallback;

  final int selectedDay = CalendarUtils.getPartByInt(format: PartFormat.DAY);

  late BoxDecoration selectedDecoration;

  @override
  Widget build(BuildContext context) {
    animateToCurrentDay();

    days = CalendarUtils.getDaysAmount();

    selectedDecoration = BoxDecoration(
      color: dayStyle?.selectedColor,
      borderRadius: BorderRadius.circular(8),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26), topRight: Radius.circular(26)),
        color: Colors.white,
      ),
      height: 380,
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '${Translator.getTranslation('day_selector')}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              //  fontFamily:dayStyle?.font,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: GridView.builder(
                    controller: _scrollController,
                    itemCount: days.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, mainAxisExtent: 50),
                    itemBuilder: (context, index) =>
                        dayWidgetMaker(days[index], context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dayWidgetMaker(day, context) {
    return InkWell(
      onTap: (() {
        Navigator.pop(context);
        onHeaderChanged.call(day);

      }),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: day == selectedDay ? selectedDecoration : null,
          child: Text(
            '$day',
            style: TextStyle(
              fontSize: 16,
              color: day == selectedDay ? Colors.white : null,
             // fontFamily: DayStyle?.font,
            ),
          ),
        ),
      ),
    );
  }

  double findSelectedDayOffset() {
    final size =
        _scrollController.position.maxScrollExtent / (days.length / 3);
    return size * (days.indexOf(selectedDay)) / 3;
  }

  void animateToCurrentDay() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_scrollController.hasClients)
        _scrollController.animateTo(findSelectedDayOffset(),
            duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
}
