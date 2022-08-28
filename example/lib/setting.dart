import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_event_calendar_example/injection.dart';
import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
import 'package:flutter_event_calendar_example/widgets/expanded_items_setting.dart';
import 'package:flutter_event_calendar_example/widgets/radio_button_list.dart';
import 'package:flutter_event_calendar_example/widgets/theme_setting.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarSetting extends StatefulWidget {
  CalendarSetting({
    Key key,
  }) : super(key: key);

  @override
  State<CalendarSetting> createState() => _CalendarSettingState();
}

class _CalendarSettingState extends State<CalendarSetting> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> listLanguage = ['Persian', 'English'];
    List<String> listCalendartype = ['Jalali', 'Miladi'];
    List<String> listMonthStringType = ['full', 'short'];

    StreamController streamController = StreamController<CalendarEventModel>();
    CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
    List<ExpandedItem> calendarOptions = [
      ExpandedItem(
        icon:'assets/language_icon.svg',
        title: "CalendarType",
        body: RadioButtonList(
          listItems: listLanguage,
          onChanged: (dynamic keyName) {
            if (keyName == 'Persian') {
              calendarEventModel.calendarLanguage = "fa";
              streamController.add(calendarEventModel);
            } else {
              calendarEventModel.calendarLanguage = "en";
              streamController.add(calendarEventModel);
            }
          },
        ),
      ),
      ExpandedItem(
          icon:'assets/language_icon.svg',

          title: "calendarLanguage",
          body: RadioButtonList(
            listItems: listCalendartype,
            onChanged: (dynamic keyName) {
              if (keyName == 'Jalali') {
                calendarEventModel.calendarType = CalendarType.JALALI;
              } else {
                calendarEventModel.calendarType = CalendarType.GREGORIAN;
              }
            },
          )),
      ExpandedItem(
        icon: 'assets/calendar.svg',
          title: "Month String Types",
          body: RadioButtonList(
            listItems: listMonthStringType,
            onChanged: (dynamic keyName) {
              if (keyName == 'Persian') {
                //calendarEventModel. = "fa";
              } else {
                //  calendarEventModel.languageCalendar = "en";
              }
            },
          )),
      ExpandedItem(
        icon:'assets/color_filter.svg',
        title: 'Calendar Color',
        body: Container(
          child: Column(
            children: [ThemeSetting()],
          ),
        ),
      )
    ];

    return Scaffold(
      backgroundColor:Color(0xffF5F5F5) ,
     appBar: AppBar(
      // automaticallyImplyLeading: false,
       backgroundColor: Color(0xffF5F5F5),
       elevation: 0,
       leading: SvgPicture.asset('assets/back.svg'),
         // Row(children: [
         //   SizedBox(width: 10,),
         //   Expanded(
         //
         //   //  margin: EdgeInsets.symmetric(horizontal: 10),
         //   child: new OutlinedButton(
         //
         //
         //     style: OutlinedButton.styleFrom(
         //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
         //     ),
         //     child: new Icon(Icons.arrow_back_ios, color: Colors.black,size: 18,),
         //     onPressed: () => Navigator.of(context).pop(),
         //   ),
         //
         // ),],),
       title: Text("Calendar Settings",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
   ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [

                SizedBox(height: 30,),
                ExpandedWidget(
                  items: calendarOptions,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
