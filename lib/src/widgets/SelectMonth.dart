import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/calendar_utils.dart';
import 'package:flutter_event_calendar/src/handlers/event_calendar.dart';
import 'package:flutter_event_calendar/src/handlers/translator.dart';

class SelectMonth extends StatelessWidget {
  late List months;

  Function onHeaderChanged;

  SelectMonth({required this.onHeaderChanged});

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
              '${Translator().getTranslation('month_selector')}',
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
                      children: monthsWidgetMaker(context),
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

  List<TableRow> monthsWidgetMaker(context) {
    months = Translator().getFullMonthNames();

    List<Widget> _buildRowCells(int rowIndex) {
      List<TableCell> widgets = [];
      for (var j = 0; j < 3; j++) {
        widgets.add(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Material(
              child: InkWell(
                onTap: (() {
                  Navigator.pop(context);
                  CalendarUtils().goToMonth((rowIndex * 3) + j + 1);
                  onHeaderChanged.call();
                }),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                      child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      '${months[(rowIndex * 3) + j].toString()}',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: EventCalendar.font,
                      ),
                      maxLines: 1,
                    ),
                  )),
                ),
              ),
            ),
          ),
        );
      }
      return widgets;
    }

    List<TableRow> monthsWidget = [];
    for (var i = 0; i < 4; i++) {
      monthsWidget.add(TableRow(children: _buildRowCells(i)));
    }

    return monthsWidget;
  }
}
