import 'package:alraaqi_app/features/quran/controller/tabs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_quran/flutter_quran.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabsController());
    return FlutterQuranScreen(
      icon: controller.appSettingsPrefs.getLocale() == "ar"
          ? Icon(Icons.arrow_forward_ios)
          : Icon(Icons.arrow_back_ios),
    );
  }
}
