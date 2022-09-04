// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_event_calendar/flutter_event_calendar.dart';
// import 'package:flutter_event_calendar_example/injection.dart';
// import 'package:flutter_event_calendar_example/models/calendar_event_model.dart';
// import 'package:flutter_event_calendar_example/models/expanded_item_model.dart';
// import 'package:flutter_event_calendar_example/widgets/expanded_card_setting.dart';
// import 'package:flutter_event_calendar_example/widgets/radio_button_list.dart';
// import 'package:flutter_event_calendar_example/widgets/calendar_color_item.dart';
//
// class DayOptionSetting extends StatefulWidget {
//   DayOptionSetting({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<DayOptionSetting> createState() => _DayOptionSettingState();
// }
//
// class _DayOptionSettingState extends State<DayOptionSetting> {
//   late StreamController streamController;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> languageList = ['fa', 'en'];
//     List<String> calendarTypeList = [
//       CalendarType.JALALI.name,
//       CalendarType.GREGORIAN.name
//     ];
//     List<String> calendarMonthTypeList = [
//       MonthStringTypes.SHORT.name,
//       MonthStringTypes.FULL.name
//     ];
//     List<String> toggleViewTypeList = ['true', 'false'];
//     streamController = getit<StreamController<CalendarEventModel>>();
//     CalendarEventModel calendarEventModel = getit<CalendarEventModel>();
//     List<ExpandedItemModel> settingItemsCalendarOptions = [
//       ExpandedItemModel(
//         icon: 'assets/language_icon.svg',
//         title: "Calendar Language",
//         body: RadioButtonList(
//           initValue: calendarEventModel.calendarLanguage,
//           listItems: languageList,
//           onChanged: (dynamic keyName) {
//             calendarEventModel.calendarLanguage = keyName;
//             streamController.sink.add(calendarEventModel);
//           },
//         ),
//       ),
//       ExpandedItemModel(
//         icon: 'assets/language_icon.svg',
//         title: "Calendar Type",
//         body: RadioButtonList(
//           initValue: calendarEventModel.calendarType.name,
//           listItems: calendarTypeList,
//           onChanged: (dynamic keyName) {
//             calendarEventModel.calendarType = CalendarType.values
//                 .firstWhere((element) => element.name == keyName);
//             streamController.sink.add(calendarEventModel);
//           },
//         ),
//       ),
//
//       ExpandedItemModel(
//         icon: 'assets/calendar.svg',
//         title: "ToggleView Type",
//         body: RadioButtonList(
//             initValue:
//             calendarEventModel.calendarOptions.toggleViewType.toString(),
//             listItems: toggleViewTypeList,
//             onChanged: (dynamic keyName) {
//               calendarEventModel.calendarOptions.toggleViewType =
//                   keyName.toLowerCase() == 'true';
//               streamController.sink.add(calendarEventModel);
//             }),
//       ),
//
//       ExpandedItemModel(
//         icon: 'assets/color_filter.svg',
//         title: 'Calendar Color',
//         body: ColorPickerList(),
//       )
//     ];
//
//     return
//
//       Container(
//         margin: EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 30,
//             ),
//             Text("CalendarOptions",style: TextStyle(fontWeight: FontWeight.bold),),
//             SizedBox(
//               height: 30,
//             ),
//             ListView.builder(
//               itemCount: settingItemsCalendarOptions.length,
//               shrinkWrap: true,
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   padding: EdgeInsets.symmetric(vertical: 5),
//                   child: ExpandedWidget(
//                     items: settingItemsCalendarOptions,
//                     index: index,
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//
//   }
// }
