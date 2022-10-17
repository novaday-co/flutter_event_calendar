import 'package:flutter/material.dart';
import 'package:flutter_event_calendar_example/models/expanded_item_model.dart';
import 'package:flutter_event_calendar_example/widgets/setting/expanded_card_setting.dart';

class ItemSetting extends StatefulWidget {
  ItemSetting(
      {Key? key, required this.expandeditemModelList, required this.title})
      : super(key: key);
  List<ExpandedItemModel> expandeditemModelList;
  String title;
  @override
  State<ItemSetting> createState() => _ItemSettingState();
}

class _ItemSettingState extends State<ItemSetting> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.expandeditemModelList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ExpandedWidget(
                    items: widget.expandeditemModelList,
                    index: index,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Text(
                        widget.expandeditemModelList[index].definition,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.start,
                      ),
                    )),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
