import 'package:flutter/material.dart';

class RadioButtonList extends StatefulWidget {
  RadioButtonList(
      {Key key,
     @required this.onChanged,
        @required this.listItems,
      })
      : super(key: key);

  Function(dynamic keyName) onChanged;
  List<String> listItems;
  @override
  State<RadioButtonList> createState() => _RadioButtonListState();
}


class _RadioButtonListState extends State<RadioButtonList> {
  var groubValueKey = "parisima";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // streamController.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Column(

        children: [
          ListView.builder(
            itemCount: widget.listItems.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return RadioListTile(
                title: Text(widget.listItems[index]),
                value: widget.listItems[index],
                groupValue: groubValueKey,
                onChanged: (value) {
                  setState(() {
                    print("value"+value);
                    groubValueKey = value;
                     widget.onChanged(value);
                  });
                },
              );
            },
          ),


        ],
      ),
    );
  }
}
