import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_event_calendar_example/models/expanded_item_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpandedWidget extends StatelessWidget {
  ExpandedWidget({Key? key, required this.items, required this.index})
      : super(key: key);
  final List<ExpandedItemModel> items;
  final int index;
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: ScrollOnExpand(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: <Widget>[
            ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToExpand: true,
                tapBodyToCollapse: false,
                hasIcon: false,
              ),
              header: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        SvgPicture.asset(items[index].icon),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          items[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ExpandableIcon(
                      theme: const ExpandableThemeData(
                        expandIcon: Icons.keyboard_arrow_down_outlined,
                        collapseIcon: Icons.keyboard_arrow_up,
                        iconColor: Colors.grey,
                        iconSize: 18.0,
                        iconRotationAngle: 3.14 / 2,
                        iconPadding: EdgeInsets.only(right: 5),
                        hasIcon: false,
                      ),
                    ),
                  ],
                ),
              ),
              collapsed: Container(),
              expanded: items[index].body,
            ),
          ],
        ),
      ),
    ));
  }
}
