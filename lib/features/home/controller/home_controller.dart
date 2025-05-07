import 'dart:async';
import 'package:alraaqi_app/core/constant/image_url.dart';
import 'package:alraaqi_app/core/data/data.dart';
import 'package:alraaqi_app/core/functions/check_internet.dart';
import 'package:alraaqi_app/core/functions/save_prayTimer.dart';
import 'package:alraaqi_app/features/pray_time/controller/prayTime_controller.dart';
import 'package:alraaqi_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late Timer _timer;
  late bool serviceEnable;
  late PageController pageController;
  late var dua;
  var counter = 0.obs;
  int currentPage = 0;
  final controller = Get.put(PrayTimeController());

  List itemData = [
    {"name": "صوتيات", "imageUrl": ImageUrl.audio, "onPressed": Routes.audio},
    {"name": "القرآن", "imageUrl": ImageUrl.quran, "onPressed": Routes.quran},
    {
      "name": "أذكار الصباح",
      "imageUrl": ImageUrl.athkarMorning,
      "onPressed": Routes.athkarMornign
    },
    {
      "name": "أذكار المساء",
      "imageUrl": ImageUrl.athkarNight,
      "onPressed": Routes.athkarEvning
    },
    {"name": "الرقية", "imageUrl": ImageUrl.athkar, "onPressed": Routes.roqia},
    {"name": "القبلة", "imageUrl": ImageUrl.qibla, "onPressed": Routes.qibla},
    {
      "name": "التحصينات",
      "imageUrl": ImageUrl.hadeas,
      "onPressed": Routes.tahseen
    },
    {
      "name": "المؤذن",
      "imageUrl": ImageUrl.pray_time,
      "onPressed": Routes.pray_time
    },
  ];

  String ayha(index) {
    return Data.ayah[index]['text1'];
  }

  changeCounter() {
    counter.value = counter.value + 1;
  }

  readData() async {
    dua = (Data.sunnah..shuffle()).first;
    update();
  }

  String tafseer(index) {
    return Data.ayah[index]['text2'];
  }

  String share(index) {
    String data = "${ayha(index)}\n${tafseer(index)}";
    return data;
  }

  void onPageChange(int index) {
    currentPage = index;
    update();
  }

  @override
  void onInit() {
    readData();
    super.onInit();
    pageController = PageController();
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (Timer timer) {
        if (currentPage < 11) {
          currentPage++;
        } else {
          currentPage = 0;
        }
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      },
    );
    saveData(controller);
  }
}
