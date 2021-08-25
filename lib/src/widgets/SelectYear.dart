import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/handlers/Translator.dart';

class SelectYear extends StatelessWidget {
  late List years;

  Function onHeaderChanged;

  SelectYear({required this.onHeaderChanged});

  @override
  Widget build(BuildContext context) {
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
              '${Translator().trans('year_selector')}',
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Table(
                      border: new TableBorder(
                        horizontalInside:
                            BorderSide(color: Colors.black12, width: 0.2),
                        verticalInside:
                            BorderSide(color: Colors.black12, width: 0.2),
                      ),
                      children: yearsWidgetMaker(context),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<TableRow> yearsWidgetMaker(context) {
    years = CalendarSelector().getYears();
    List<TableRow> yearsWidget = [];
    for (var i = 0; i < years.length; i++) {
      yearsWidget.add(TableRow(children: [
        TableCell(
          child: InkWell(
            onTap: (() {
              Navigator.pop(context);
              CalendarSelector().goToYear(years[i]);
              onHeaderChanged.call();
            }),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                  child: Text(
                '${years[i].toString()}',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: EventCalendar.font,
                ),
              )),
            ),
          ),
        ),
      ]));
    }

    return yearsWidget;
  }
}
