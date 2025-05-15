import 'dart:async';
import 'package:alraaqi_app/core/cache/dependency_injection.dart';
import 'package:alraaqi_app/core/constant/image_url.dart';
import 'package:alraaqi_app/core/constant/manager_strings.dart';
import 'package:alraaqi_app/core/data/data.dart';
import 'package:alraaqi_app/core/functions/awesome_dialog.dart';
import 'package:alraaqi_app/core/functions/save_prayTimer.dart';
import 'package:alraaqi_app/core/localization/locales.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:alraaqi_app/features/audio/controller/audio_controller.dart';
import 'package:alraaqi_app/features/pray_time/controller/prayTime_controller.dart';
import 'package:alraaqi_app/routes/routes.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late Timer timer;
  late bool serviceEnable;
  late PageController pageController;
  BuildContext context = Get.context!;
  late var dua;
  var counter = 0.obs;
  int currentPage = 0;
  final controller = Get.put(PrayTimeController());
  final controllerAudio = Get.put(AudioController());
  SharedPrefController appSettingsPrefs = instance<SharedPrefController>();
  final languagesList = LocaleSettings.languages;
  String get currentLanguage => appSettingsPrefs.getLocale();

  Future<void> changeLanguage(
      {required BuildContext context, required String languageCode}) async {
    this.appSettingsPrefs.setLocale(languageCode);
    EasyLocalization.of(context)!.setLocale(Locale(languageCode));
    Get.updateLocale(Locale(languageCode));
    update();
  }

  List get itemData => [
        {
          "name": ManagerStrings.audios,
          "imageUrl": ImageUrl.audio,
          "onPressed": Routes.audio
        },
        {
          "name": ManagerStrings.quran,
          "imageUrl": ImageUrl.quran,
          "onPressed": Routes.quran
        },
        {
          "name": ManagerStrings.morningAzkar,
          "imageUrl": ImageUrl.athkarMorning,
          "onPressed": Routes.athkarMornign
        },
        {
          "name": ManagerStrings.eveningAzkar,
          "imageUrl": ImageUrl.athkarNight,
          "onPressed": Routes.athkarEvning
        },
        {
          "name": ManagerStrings.ruqyah,
          "imageUrl": ImageUrl.athkar,
          "onPressed": Routes.roqia
        },
        {
          "name": ManagerStrings.qibla,
          "imageUrl": ImageUrl.qibla,
          "onPressed": Routes.qibla
        },
        {
          "name": ManagerStrings.protections,
          "imageUrl": ImageUrl.hadeas,
          "onPressed": Routes.tahseen
        },
        {
          "name": ManagerStrings.muezzin,
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
    timer = Timer.periodic(
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
    Future.delayed(Duration(seconds: 1), () {
      showAwesomeDialog(
          context: context,
          description: ManagerStrings.titleDialog,
          btnOkOnPress: () {
            showAwesomeDialog(
                context: context,
                description: ManagerStrings.titleDialog2,
                btnOkOnPress: () {
                  Get.back();
                },
                dialogType: DialogType.info);
          },
          dialogType: DialogType.info);
    });
  }
}
