import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:flutter_event_calendar/src/handlers/event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/translator.dart';

class SelectYear extends StatelessWidget {
  late List years;

  Function onHeaderChanged;
  ScrollController _scrollController = ScrollController();

  SelectYear({required this.onHeaderChanged});

  late VoidCallback scrollToPositionCallback;

  final int selectedYear =
        CalendarUtils().getPart(format: PartFormat.month, responseType: 'int');

  final selectedDecoration = BoxDecoration(
    color: EventCalendar.dayIndexSelectedBackgroundColor,
    borderRadius: BorderRadius.circular(8),
  );

  @override
  Widget build(BuildContext context) {
    animateToCurrentYear();

    years = CalendarUtils().getYears();

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
              '${Translator().getTranslation('year_selector')}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: EventCalendar.font,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Material(
                child: GridView.builder(
                    controller: _scrollController,
                    itemCount: years.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, mainAxisExtent: 50),
                    itemBuilder: (context, index) =>
                        yearWidgetMaker(years[index], context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget yearWidgetMaker(year, context) {
    print("${year == selectedYear}");
    return InkWell(
      onTap: (() {
        Navigator.pop(context);
        CalendarUtils().goToYear(year);
        onHeaderChanged.call();
      }),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: year == selectedYear ? selectedDecoration : null,
          child: Text(
            '$year',
            style: TextStyle(
              fontSize: 16,
              color: year == selectedYear ? Colors.white : null,
              fontFamily: EventCalendar.font,
            ),
          ),
        ),
      ),
    );
  }

  double findSelectedYearOffset() {
    final size =
        _scrollController.position.maxScrollExtent / (years.length / 3);
    return size * (years.indexOf(selectedYear)) / 3;
  }

  void animateToCurrentYear() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(findSelectedYearOffset(),
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
}
