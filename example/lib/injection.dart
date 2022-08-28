import 'dart:async';

import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:get_it/get_it.dart';

import 'models/calendar_event_model.dart';
import 'models/calender_setting_item_model.dart';

final getit = GetIt.instance;

setUp(){

 getit.registerLazySingleton<HeaderOptions>(() => HeaderOptions(monthStringType: MonthStringTypes.SHORT));
  getit.registerLazySingleton(() => CalendarEventModel(calendarLanguage: "fa",calendarType: CalendarType.JALALI,headerOptions: getit()));
  getit.registerLazySingleton<StreamController<String>>(() => StreamController());
  getit.registerLazySingleton<StreamController<CalendarEventModel>>(() => StreamController());

  // sl.registerLazySingleton(() => Stream<String>());
// Creating a new stream through the controller
 // Stream<String> stream = streamController.stream.asBroadcastStream();


}