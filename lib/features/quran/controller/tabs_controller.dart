import 'package:alraaqi_app/core/cache/dependency_injection.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:flutter_quran/flutter_quran.dart';
import 'package:get/get.dart';

class TabsController extends GetxController {
  SharedPrefController appSettingsPrefs = instance<SharedPrefController>();

  @override
  void onInit() {
    super.onInit();
    FlutterQuran().init();
  }
}
