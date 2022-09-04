
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar_example/models/expanded_item_model.dart';
import 'package:flutter_event_calendar_example/widgets/setting/expanded_card_setting.dart';

class itemSetting extends StatefulWidget {
  itemSetting({Key? key,required this.expandeditemModelList,required this.title}) : super(key: key);
  List<ExpandedItemModel> expandeditemModelList;
  String title;
  @override
  State<itemSetting> createState() => _itemSettingState();
}

class _itemSettingState extends State<itemSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            widget.title,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
          ),
          SizedBox(
            height: 30,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.expandeditemModelList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: ExpandedWidget(
                      items: widget.expandeditemModelList,
                      index: index,
                    ),
                  ),
                  Container( margin: EdgeInsets.symmetric(horizontal: 10),padding: EdgeInsets.symmetric(vertical: 5),child: Text(widget.expandeditemModelList[index].definition,style: TextStyle(fontSize: 12),textAlign: TextAlign.justify,)),

                ],
              );
            },
          ),

        ],
      ),
    );
  }
}
