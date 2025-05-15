import 'package:alraaqi_app/core/cache/dependency_injection.dart';
import 'package:alraaqi_app/core/class/awesome_notifications_manager.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:alraaqi_app/features/pray_time/controller/prayTime_controller.dart';
import 'package:get/get.dart';

class CheckNotifications {
  SharedPrefController _appSettings = instance<SharedPrefController>();

  PrayTimeController prayTimeController = Get.put(PrayTimeController());
  prayTimeNotification() {
    NotificationManager.displayPrayTimeNotification(
        id: 1,
        title: "اذان الفجر",
        description: "حان الان موعد صلاة الفجر",
        hour: _appSettings.fajrHour!,
        minute: _appSettings.fajrMinute!);
    NotificationManager.displayPrayTimeNotification(
        id: 2,
        title: "اذان الظهر",
        description: "حان الان موعد صلاة الظهر",
        hour: _appSettings.dhurHour!,
        minute: _appSettings.dhurMinute!);
    NotificationManager.displayPrayTimeNotification(
        id: 3,
        title: "اذان العصر",
        description: "حان الان موعد صلاة العصر",
        hour: _appSettings.asrHour!,
        minute: _appSettings.asrMinute!);
    NotificationManager.displayPrayTimeNotification(
        id: 4,
        title: "اذان المغرب",
        description: "حان الان موعد صلاة المغرب",
        hour: _appSettings.magrabHour!,
        minute: _appSettings.magrabMinute!);
    NotificationManager.displayPrayTimeNotification(
        id: 5,
        title: "اذان العشاء",
        description: "حان الان موعد صلاة العشاء",
        hour: _appSettings.ishaHour!,
        minute: _appSettings.ishaMinute!);
  }
}
