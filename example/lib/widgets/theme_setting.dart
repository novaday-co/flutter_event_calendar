import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';

class ThemeSetting extends StatefulWidget {
  const ThemeSetting({Key key}) : super(key: key);

  @override
  State<ThemeSetting> createState() => _ThemeSettingState();
}
// create some values

class _ThemeSettingState extends State<ThemeSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            ColorCard(
              title: "Calendar Background",
            ),
            ColorCard(
              title: "Header Background",
            ),
          ],
        ),
      ),
    );
  }
}

class ColorCard extends StatefulWidget {
  ColorCard({Key key, @required this.title}) : super(key: key);

  final String title;

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  @override
  State<ColorCard> createState() => _ColorCardState();
}

class _ColorCardState extends State<ColorCard> {
  StreamController<CalendarEventModel> streamController =
      getit<StreamController<CalendarEventModel>>();

  void changeColor(Color color) {
    setState(() => widget.pickerColor = color);
    // streamController.add(
    //   CalendarEventModel(calendarLanguage: "Fa", calendarType: CalendarType.JALALI, calendarOptions: CalendarOptions(headerMonthBackColor: widget.currentColor))
    // );
  }

  showColorPickerDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: widget.pickerColor,
                onColorChanged: changeColor,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Got it'),
                onPressed: () {
                  setState(() => widget.currentColor = widget.pickerColor);

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(

        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.bold,),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: InkWell(
                  onTap: showColorPickerDialog,
                  child: Card(
                      margin: EdgeInsets.only(right: 8,),

                      color: widget.currentColor,
                      child: Text(""))),
            )
          ],
        ));
  }
}
