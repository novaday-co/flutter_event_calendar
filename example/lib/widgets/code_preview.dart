import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:clipboard/clipboard.dart';
//codepreview
class CodePreview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CodePreviewState();
}

class CodePreviewState extends State<CodePreview> {
  late Stream stream;
  late StreamSubscription<CalendarEventModel> streamSubscription;
  StreamController<CalendarEventModel> streamController=getit<StreamController<CalendarEventModel>>();
  CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
  @override
  void initState() {
    streamController.stream.listen((event) {
      print("listened");
      setState(() {
        calendarEventModel=event;
      });
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
      calendarOptions: CalendarOptions(headerMonthBackColor: ${calendarEventModel.calendarOptions.headerMonthBackColor},),
      dayOptions: DayOptions(selectedBackgroundColor:${calendarEventModel.dayOptions.selectedBackgroundColor}),
      headerOptions: HeaderOptions(
          monthStringType:
          ${calendarEventModel.headerOptions.monthStringType}),
    )""";

    void copyCodePreview(){
      FlutterClipboard.copy(code).then(( value ) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("copied"),
        backgroundColor: Colors.grey,
      )));

    }

    SyntaxView syntaxView =SyntaxView(
    code: code,
    syntax: Syntax.DART,
    syntaxTheme: SyntaxTheme.vscodeLight(),
    fontSize: 12.0,
    withZoom: true,
    withLinesCount: true,
    expanded: true);
    return Scaffold(
      body:

               Stack(
                alignment: AlignmentDirectional.topEnd,
                 children: [


                   Container(
                       height: MediaQuery.of(context).size.height,
                       child: syntaxView),
                   ElevatedButton(
                     child: const Icon(Icons.copy),
                     onPressed: () {

                       copyCodePreview();
                     },
                   ),
                 ],
               )



    );
  }
}