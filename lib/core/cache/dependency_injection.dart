import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hijri/hijri_calendar.dart';

import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;
initModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  if (!GetIt.I.isRegistered<SharedPreferences>()) {
    instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  }
  if (!GetIt.I.isRegistered<SharedPrefController>()) {
    instance.registerLazySingleton<SharedPrefController>(
        () => SharedPrefController(instance()));
  }
  SharedPrefController _appSettings = instance<SharedPrefController>();
  HijriCalendar.setLocal(_appSettings.getLocale());
}
