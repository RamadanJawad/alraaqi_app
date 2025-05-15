import 'package:alraaqi_app/core/constant/image_url.dart';
import 'package:alraaqi_app/core/constant/manager_strings.dart';
import 'package:alraaqi_app/features/pray_time/controller/prayTime_controller.dart';
import 'package:intl/intl.dart';

check(PrayTimeController controller) {
  if (controller.prayerTimes.nextPrayer().toString() == "Prayer.none") {
    controller.currentPray = ManagerStrings.fajrPrayer;
    controller.image = ImageUrl.fajr;
    controller.prayTime = DateFormat.jm().format(controller.prayerTimes.fajr);
    controller.dateTime =
        controller.prayerTimes.fajr.toLocal().add(const Duration(days: 1));
  } else if (controller.prayerTimes.nextPrayer().toString() == "Prayer.isha") {
    controller.currentPray = ManagerStrings.ishaPrayer;
    controller.image = ImageUrl.isha;
    controller.prayTime = DateFormat.jm().format(controller.prayerTimes.isha);
    controller.dateTime = controller.prayerTimes.isha;
  } else if (controller.prayerTimes.nextPrayer().toString() ==
      "Prayer.maghrib") {
    controller.currentPray = ManagerStrings.maghribPrayer;
    controller.image = ImageUrl.maghrib;
    controller.prayTime =
        DateFormat.jm().format(controller.prayerTimes.maghrib);
    controller.dateTime = controller.prayerTimes.maghrib;
  } else if (controller.prayerTimes.nextPrayer().toString() == "Prayer.asr") {
    controller.currentPray = ManagerStrings.asrPrayer;
    controller.image = ImageUrl.asr;
    controller.prayTime = DateFormat.jm().format(controller.prayerTimes.asr);
    controller.dateTime = controller.prayerTimes.asr;
  } else if (controller.prayerTimes.nextPrayer().toString() == "Prayer.dhuhr") {
    controller.currentPray = ManagerStrings.dhuhrPrayer;
    controller.image = ImageUrl.dhuhr;
    controller.prayTime = DateFormat.jm().format(controller.prayerTimes.dhuhr);
    controller.dateTime = controller.prayerTimes.dhuhr;
  } else if (controller.prayerTimes.nextPrayer().toString() ==
      "Prayer.sunrise") {
    controller.currentPray = ManagerStrings.shurooqPrayer;
    controller.image = ImageUrl.sunrise;
    controller.prayTime =
        DateFormat.jm().format(controller.prayerTimes.sunrise);
    controller.dateTime = controller.prayerTimes.sunrise;
  } else {
    controller.currentPray = "الفجر";
    controller.image = ImageUrl.fajr;
    controller.prayTime = DateFormat.jm().format(controller.prayerTimes.fajr);
    controller.dateTime = controller.prayerTimes.fajr.toLocal();
  }
}
