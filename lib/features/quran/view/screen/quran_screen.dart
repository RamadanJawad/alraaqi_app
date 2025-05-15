import 'package:alraaqi_app/features/quran/controller/tabs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_quran/flutter_quran.dart';


class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TabsController());
    return const FlutterQuranScreen();
  }
}
