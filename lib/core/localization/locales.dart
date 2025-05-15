import 'package:alraaqi_app/core/cache/dependency_injection.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:flutter/material.dart';

LocaleSettings localeSettings = LocaleSettings();

class LocaleSettings {
  final SharedPrefController settingsPrefs;

  LocaleSettings() : settingsPrefs = instance<SharedPrefController>();

  static const Map<String, String> languages = {
    'ar': 'العربية',
    'en': 'الانجليزية',
  };

  List<Locale> get locales => languages.keys.map((e) => Locale(e)).toList();

  Locale get defaultLocale => Locale(settingsPrefs.getLocale());
}
