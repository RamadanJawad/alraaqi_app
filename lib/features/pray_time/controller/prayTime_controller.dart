import 'package:adhan/adhan.dart';
import 'package:alraaqi_app/core/cache/dependency_injection.dart';
import 'package:alraaqi_app/core/functions/notification.dart';
import 'package:alraaqi_app/core/functions/snackbar.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hijri/hijri_calendar.dart';

class PrayTimeController extends GetxController {
  late SharedPreferences sharedPreferences;
  SharedPrefController appSettings = instance<SharedPrefController>();
  late String currentPray;
  SharedPrefController appSettingsPrefs = instance<SharedPrefController>();
  bool value = false;
  late String prayTime;
  late PrayerTimes prayerTimes;
  BuildContext context = Get.context!;
  late Coordinates coordinates;
  late CalculationParameters parameter;
  late PageController pageController;
  late String image;
  late DateTime dateTime = DateTime.now();
  bool isTapped = false;
  bool isTapped1 = false;
  bool isTapped2 = false;
  bool isTapped3 = false;
  bool isTapped4 = false;
  bool isTapped5 = false;
  String? hijri;

  showDate() {
    var today = HijriCalendar.now();
    hijri = today.fullDate();
  }

  isTapController() {
    isTapped = !isTapped;
    update();
  }

  isTapController1() {
    isTapped1 = !isTapped1;
    update();
  }

  isTapController2() {
    isTapped2 = !isTapped2;
    update();
  }

  isTapController3() {
    isTapped3 = !isTapped3;
    update();
  }

  isTapController4() {
    isTapped4 = !isTapped4;
    update();
  }

  isTapController5() {
    isTapped5 = !isTapped5;
    update();
  }

  initPryTime() {
    parameter = CalculationMethod.egyptian.getParameters();
    parameter.madhab = Madhab.shafi;
    coordinates = Coordinates(
        appSettings.latitude ?? 25.354826, appSettings.longitude ?? 51.183884);
    prayerTimes = PrayerTimes.today(coordinates, parameter);
    update();
  }

  prayTimeNotification() async {
    bool? isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
      return;
    }
    bool status = appSettings.status1;
    status = !status;
    appSettings.saveStatus1(
        status1: status); // Make sure this saves to SharedPreferences
    if (status) {
      CheckNotifications().prayTimeNotification();
      showSnackBar(context, "تم تفعيل اشعارات أوقات الصلاة بنجاح",
          Colors.grey); // Enable notifications
    } else {
      for (int i = 1; i <= 5; i++) {
        AwesomeNotifications().cancelSchedule(i);
      }
      showSnackBar(context, "تم ايقاف اشعارات أوقات الصلاة ", Colors.grey);
    }
    update(); // If you're using GetX or similar for UI update
  }

  @override
  void onInit() {
    showDate();
    initPryTime();
    super.onInit();
  }
}
