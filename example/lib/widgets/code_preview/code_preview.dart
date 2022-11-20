import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:clipboard/clipboard.dart';

class CodePreview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CodePreviewState();
}

class CodePreviewState extends State<CodePreview> {
  StreamController<CalendarEventModel> streamController =
      getit<StreamController<CalendarEventModel>>();
  CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
  late String code;
  @override
  void initState() {
    streamController.stream.listen((event) {
      calendarEventModel = event;
    });
    super.initState();

    code = """
                EventCalendar(
              specialDays:${calendarEventModel.specialDays},
              calendarType: ${calendarEventModel.calendarType},
              calendarLanguage: ${calendarEventModel.calendarLanguage} ,
                   calendarOptions: CalendarOptions(
                viewType: ${calendarEventModel.calendarOptions.viewType},
                headerMonthBackColor:
                    ${calendarEventModel.calendarOptions.headerMonthBackColor},
                toggleViewType:
                    ${calendarEventModel.calendarOptions.toggleViewType},
                font: ${calendarEventModel.calendarOptions.font}),
              dayOptions: DayOptions(selectedBackgroundColor:${calendarEventModel.dayOptions.selectedBackgroundColor}),
              headerOptions: HeaderOptions(
                headerTextColor:${calendarEventModel.headerOptions.headerTextColor},
                navigationColor:${calendarEventModel.headerOptions.navigationColor},
                  monthStringType:
                     ${calendarEventModel.headerOptions.monthStringType},
                     weekDayStringType: ${calendarEventModel.headerOptions.weekDayStringType},
              ),
            ),
            """;
  }

  SyntaxView syntaxViewTheme() {
    return SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.vscodeLight(),
        fontSize: 12.0,
        withZoom: true,
        withLinesCount: true,
        expanded: true);
  }

  void copyCodePreview() {
    FlutterClipboard.copy(code)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Copied"),
              backgroundColor: Colors.grey,
              duration: const Duration(seconds: 1),
            )));
  }

  @override
  Widget build(BuildContext context) {
    SyntaxView syntaxView = syntaxViewTheme();

    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10, left: 10),
          height: MediaQuery.of(context).size.height,
          child: syntaxView,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
            ),
            child: const Icon(Icons.copy),
            onPressed: () {
              copyCodePreview();
            },
          ),
        ),
      ],
    ));
  }
}
