import 'package:flutter/material.dart';
import '../../flutter_event_calendar.dart';
import '../handlers/calendar_utils.dart';
import '../handlers/translator.dart';
import '../models/style/select_year_options.dart';

class SelectYear extends StatelessWidget {
  late List years;

  Function(int year) onHeaderChanged;

  YearOptions? yearStyle;

  SelectYear({required this.onHeaderChanged, this.yearStyle});

  ScrollController _scrollController = ScrollController();

  late VoidCallback scrollToPositionCallback;

  final int selectedYear = CalendarUtils.getPartByInt(format: PartFormat.YEAR);

  late BoxDecoration selectedDecoration;

  @override
  Widget build(BuildContext context) {
    animateToCurrentYear();

    years = CalendarUtils.getYears();

    selectedDecoration = BoxDecoration(
      color: yearStyle?.selectedColor,
      borderRadius: BorderRadius.circular(8),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26), topRight: Radius.circular(26)),
        color: yearStyle?.backgroundColor,
      ),
      height: 380,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '${Translator.getTranslation('year_selector')}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: yearStyle?.font,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: GridView.builder(
                    controller: _scrollController,
                    itemCount: years.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    return InkWell(
      onTap: (() {
        Navigator.pop(context);
        onHeaderChanged.call(year);
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
              fontFamily: yearStyle?.font,
            ),
          ),
        ),
      ),
    );
  }

  double findSelectedYearOffset() {
    final size = _scrollController.position.maxScrollExtent / (years.length / 3);
    return size * (years.indexOf(selectedYear)) / 3;
  }

  void animateToCurrentYear() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_scrollController.hasClients)
        _scrollController.animateTo(findSelectedYearOffset(),
            duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
}
