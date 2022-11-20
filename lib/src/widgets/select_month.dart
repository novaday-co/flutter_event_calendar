import 'package:flutter/material.dart';

import '../../flutter_event_calendar.dart';
import '../handlers/calendar_utils.dart';
import '../handlers/translator.dart';
import '../models/style/select_month_options.dart';

class SelectMonth extends StatelessWidget {
  late List months;

  Function(int selectedMonth) onHeaderChanged;

  MonthOptions? monthStyle;

  SelectMonth({required this.onHeaderChanged, this.monthStyle});

  late BoxDecoration selectedDecoration;

  final int currentMonth = CalendarUtils.getPartByInt(format: PartFormat.MONTH);

  @override
  Widget build(BuildContext context) {
    selectedDecoration = BoxDecoration(
      color: monthStyle?.selectedColor,
      borderRadius: BorderRadius.circular(8),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26), topRight: Radius.circular(26)),
        color: monthStyle?.backgroundColor,
      ),
      height: 380,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '${Translator.getTranslation('month_selector')}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: monthStyle?.font,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Table(
                      border: const TableBorder(
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
    months = Translator.getFullMonthNames();

    List<Widget> _buildRowCells(int rowIndex) {
      List<TableCell> widgets = [];
      for (var j = 0; j < 3; j++) {
        final int mMonth = (rowIndex * 3) + j + 1;
        widgets.add(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: (() {
                  Navigator.pop(context);
                  onHeaderChanged.call(mMonth);
                }),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: mMonth == currentMonth ? selectedDecoration : null,
                  child: Center(
                      child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      months[(rowIndex * 3) + j].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: mMonth == currentMonth ? Colors.white : null,
                        fontFamily: monthStyle?.font,
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
