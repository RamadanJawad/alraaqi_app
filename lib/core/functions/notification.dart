import 'package:alraaqi_app/core/class/awesome_notifications_manager.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:alraaqi_app/features/pray_time/controller/prayTime_controller.dart';
import 'package:get/get.dart';

class CheckNotifications {
  PrayTimeController prayTimeController = Get.put(PrayTimeController());
  prayTimeNotification() {
    NotificationManager.displayPrayTimeNotification(
        id: 1,
        title: "اذان الفجر",
        description: "حان الان موعد صلاة الفجر",
        hour: SharedPrefController().fajrHour!,
        minute: SharedPrefController().fajrMinute!);
    NotificationManager.displayPrayTimeNotification(
        id: 2,
        title: "اذان الظهر",
        description: "حان الان موعد صلاة الظهر",
        hour: SharedPrefController().dhurHour!,
        minute: SharedPrefController().dhurMinute!);
    NotificationManager.displayPrayTimeNotification(
        id: 3,
        title: "اذان العصر",
        description: "حان الان موعد صلاة العصر",
        hour: SharedPrefController().asrHour!,
        minute: SharedPrefController().asrMinute!);
    NotificationManager.displayPrayTimeNotification(
        id: 4,
        title: "اذان المغرب",
        description: "حان الان موعد صلاة المغرب",
        hour: SharedPrefController().magrabHour!,
        minute: SharedPrefController().magrabMinute!);
    NotificationManager.displayPrayTimeNotification(
        id: 5,
        title: "اذان العشاء",
        description: "حان الان موعد صلاة العشاء",
        hour: SharedPrefController().ishaHour!,
        minute: SharedPrefController().ishaMinute!);
  }
}
