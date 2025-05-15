import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/features/audio/controller/audio_controller.dart';
import 'package:alraaqi_app/features/audio/view/widget/surah_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SurahScreen extends StatelessWidget {
  const SurahScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AudioController>();
    return Directionality(
      textDirection: controller.appSettingsPrefs.getLocale() == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(controller.name,
              style: TextStyle(
                  fontFamily: "Noor",
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          backgroundColor: ColorCode.mainColor,
          elevation: 0,
        ),
        body: const SurahWidget(),
      ),
    );
  }
}
