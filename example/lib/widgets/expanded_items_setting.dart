import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpandedWidget extends StatefulWidget {
  ExpandedWidget({Key key, @required this.items}) : super(key: key);

  final List<ExpandedItem> items;
  @override
  State<ExpandedWidget> createState() => _ExpandedWidgetState();
}

class ExpandedItem {
  const ExpandedItem(
      {@required this.title, @required this.body, @required this.icon});
  final String title;
  final String icon;
  final Widget body;
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ExpansionPanelList.radio(
        initialOpenPanelValue: 1,
        children: widget.items.map<ExpansionPanelRadio>((ExpandedItem item) {
          return ExpansionPanelRadio(
            backgroundColor: Colors.green,
            value: item.title,

            headerBuilder: (BuildContext context, bool isExpanded) {

              return Container(
                color: Colors.red,
                  margin: EdgeInsets.symmetric(horizontal: 10,),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SvgPicture.asset(item.icon ?? ""),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        item.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ));
            },
            body: item.body,
          );
        }).toList(),
      ),
    );
  }
}
