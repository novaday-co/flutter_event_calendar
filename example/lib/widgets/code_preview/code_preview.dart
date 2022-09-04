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
  late Stream stream;
  late StreamSubscription<CalendarEventModel> streamSubscription;
  StreamController<CalendarEventModel> streamController =
      getit<StreamController<CalendarEventModel>>();
  CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
  @override
  void initState() {
    streamController.stream.listen((event) {
      calendarEventModel = event;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String code = """         
                EventCalendar(
              showLoadingForEvent: true,
              calendarType: ${calendarEventModel.calendarType},
              calendarLanguage: ${calendarEventModel.calendarLanguage} ,
              calendarOptions: CalendarOptions(headerMonthBackColor: ${calendarEventModel.calendarOptions.headerMonthBackColor},
              toggleViewType: ${calendarEventModel.calendarOptions.toggleViewType}),
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

    void copyCodePreview() {
      FlutterClipboard.copy(code)
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Copied"),
                backgroundColor: Colors.grey,
              )));
    }

    SyntaxView syntaxView = SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.vscodeLight(),
        fontSize: 12.0,
        withZoom: true,
        withLinesCount: true,
        expanded: true);

    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 10, left: 10),
            height: MediaQuery.of(context).size.height,
            child: syntaxView),
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
