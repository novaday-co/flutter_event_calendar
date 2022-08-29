import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/models/calendar_color_model.dart';

class CalendarColorItem extends StatefulWidget {
  const CalendarColorItem({Key key}) : super(key: key);

  @override
  State<CalendarColorItem> createState() => _CalendarColorItemState();
}
// create some values

List<CalendarColorModel> listThemeOptions=[
  CalendarColorModel(title:"Calendar Background",color: Colors.cyan ),
  CalendarColorModel(title:"selected BackgroundColor",color: Colors.red),

];

class _CalendarColorItemState extends State<CalendarColorItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
      child: ListView.builder(
        itemCount: listThemeOptions.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return  ColorPickerRow(title: listThemeOptions[index].title,
          color:  listThemeOptions[index].color,
          );
        },
      ),
      ),
    );
  }
}







class ColorPickerRow extends StatefulWidget {
  ColorPickerRow({Key key, @required this.title,@required this.color,  @required this.onChanged,}) : super(key: key);
  final Function onChanged;
  final String title;
  final Color color;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  StreamController streamController =getit<StreamController<CalendarEventModel>>();
  CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
  @override
  State<ColorPickerRow> createState() => _ColorPickerRowState();
}

class _ColorPickerRowState extends State<ColorPickerRow> {
  StreamController<CalendarEventModel> streamController =
      getit<StreamController<CalendarEventModel>>();

  void changeColor(Color color) {
    setState(() => widget.pickerColor = color);

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
                  setState(() {
                    widget.currentColor = widget.pickerColor;
                  widget.calendarEventModel.calendarOptions.headerMonthBackColor=widget.currentColor;
                  print(widget.calendarEventModel.props);
                    streamController.add(widget.calendarEventModel);
                  }

                  );

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
