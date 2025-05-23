import 'package:alraaqi_app/core/cache/dependency_injection.dart';
import 'package:alraaqi_app/core/functions/awesome_dialog.dart';
import 'package:alraaqi_app/core/functions/save_prayTimer.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:alraaqi_app/features/pray_time/controller/prayTime_controller.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

SharedPrefController _appSettings = instance<SharedPrefController>();
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // if (!serviceEnabled) {
  //   serviceEnabled = await Geolocator.openAppSettings();
  // }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

getLatAndLong(PrayTimeController controller) async {
  Position position = await determinePosition();
  _appSettings.saveCoordinate(long: position.longitude, lat: position.latitude);
  saveData(controller);
  print("save data sucessfully");
}

checkLocation(BuildContext context, PrayTimeController controller) async {
  if (_appSettings.latitude == null &&
      _appSettings.longitude == null) {
    Future.delayed(const Duration(milliseconds: 500), () {
      showAwesomeDialog(
          context: context,
          description:
              "لتحديث أوقات الصلاة , قم بتشغيل خدمة الموقع من الشريط العلوي",
          btnOkOnPress: () => Get.delete(),
          dialogType: DialogType.info);
    });
  } else {
    saveData(controller);
  }
}
