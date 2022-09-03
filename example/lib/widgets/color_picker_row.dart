
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
class ColorPickerRow extends StatefulWidget {
  ColorPickerRow({Key? key,  required this.onChanged,required this.title}) : super(key: key);
  final Function(dynamic color) onChanged;
  final String title;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  @override
  State<ColorPickerRow> createState() => _ColorPickerRowState();
}

class _ColorPickerRowState extends State<ColorPickerRow> {

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
                    widget.onChanged(widget.currentColor);
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

                      color: widget.pickerColor,
                      child: Text(""))),
            )
          ],
        ));
  }
}
