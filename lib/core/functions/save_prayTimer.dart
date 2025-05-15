import 'package:alraaqi_app/core/cache/dependency_injection.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:alraaqi_app/features/pray_time/controller/prayTime_controller.dart';
import 'package:intl/intl.dart';

saveData(PrayTimeController controller) {
  SharedPrefController _appSettings = instance<SharedPrefController>();
  _appSettings.fajr(
      hour: controller.prayerTimes.fajr.hour,
      minute: controller.prayerTimes.fajr.minute,
      prayTime: DateFormat.jm().format(controller.prayerTimes.fajr));
  _appSettings.shrouq(
      prayTime: DateFormat.jm().format(controller.prayerTimes.sunrise));
  _appSettings.dhur(
      hour: controller.prayerTimes.dhuhr.hour,
      minute: controller.prayerTimes.dhuhr.minute,
      prayTime: DateFormat.jm().format(controller.prayerTimes.dhuhr));
  _appSettings.asr(
      hour: controller.prayerTimes.asr.hour,
      minute: controller.prayerTimes.asr.minute,
      prayTime: DateFormat.jm().format(controller.prayerTimes.asr));
  _appSettings.magrab(
      hour: controller.prayerTimes.maghrib.hour,
      minute: controller.prayerTimes.maghrib.minute,
      prayTime: DateFormat.jm().format(controller.prayerTimes.maghrib));
  _appSettings.isha(
      hour: controller.prayerTimes.isha.hour,
      minute: controller.prayerTimes.isha.minute,
      prayTime: DateFormat.jm().format(controller.prayerTimes.isha));
}
