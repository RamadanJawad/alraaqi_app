import 'package:adhan/adhan.dart';
import 'package:alraaqi_app/core/functions/notification.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hijri/hijri_calendar.dart';

class PrayTimeController extends GetxController {
  late SharedPreferences sharedPreferences;
  late String currentPray;
  bool value = false;
  late String prayTime;
  late PrayerTimes prayerTimes;
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

  getData() {
    if (SharedPrefController().status1 != null) {
      value = SharedPrefController().status1!;
    }
  }

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
    coordinates = Coordinates(SharedPrefController().latitude ?? 25.354826,
        SharedPrefController().longitude ?? 51.183884);
    prayerTimes = PrayerTimes.today(coordinates, parameter);
    update();
  }

  prayTimeNotification() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          if (SharedPrefController().status1 == true) {
            CheckNotifications().prayTimeNotification();
          } else {
            AwesomeNotifications().cancelSchedule(1);
            AwesomeNotifications().cancelSchedule(2);
            AwesomeNotifications().cancelSchedule(3);
            AwesomeNotifications().cancelSchedule(4);
            AwesomeNotifications().cancelSchedule(5);
          }
          update();
        });
      }
    });
  }

  @override
  void onInit() {
    showDate();
    initPryTime();
    getData();
    super.onInit();
  }
}
