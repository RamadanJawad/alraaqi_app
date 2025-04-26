import 'package:alraaqi_app/features/athkar/view/screen/athkar_screen.dart';
import 'package:alraaqi_app/features/home/controller/home_controller.dart';
import 'package:alraaqi_app/features/home/view/screen/home_screen.dart';
import 'package:alraaqi_app/features/pray_time/controller/prayTime_controller.dart';
import 'package:alraaqi_app/features/pray_time/view/screen/pray_time_screen.dart';
import 'package:alraaqi_app/features/qibla/view/screen/qibla_screen.dart';
import 'package:alraaqi_app/features/quran/view/screen/quran_screen.dart';
import 'package:alraaqi_app/features/roqia/view/screen/roqia_screen.dart';
import 'package:alraaqi_app/features/splash/view/screen/splash_screen.dart';
import 'package:alraaqi_app/features/tahseen/view/screen/tahseen_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Routes {
  static const String splashView = '/splash_view';
  static const String main = '/main_view';
  static const String home = '/home_view';
  static const String quran = '/quran_view';
  static const String roqia = '/roqia_view';
  // static const String setting = '/setting_view';
  // static const String allah_names = '/allah_names_view';
  static const String athkar = '/athkar_view';
  static const String tahseen = '/tahseen_view';
  static const String qibla = '/qibla_view';
  static const String pray_time = '/pray_time_view';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        // initSplash();
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.home:
        Get.put(HomeController());
        Get.put(PrayTimeController());
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.tahseen:
        return MaterialPageRoute(builder: (_) => TahseenScreen());
      case Routes.qibla:
        return MaterialPageRoute(builder: (_) => const QiblaScreen());
      case Routes.roqia:
        return MaterialPageRoute(builder: (_) => RoqiaScreen());
      case Routes.athkar:
        return MaterialPageRoute(builder: (_) => AthkarScreen());
      case Routes.quran:
        return MaterialPageRoute(builder: (_) => QuranScreen());
      // case Routes.qibla:
      //   return MaterialPageRoute(builder: (_) => QiblaScreen());
      case Routes.pray_time:
        return MaterialPageRoute(builder: (_) => PrayTimeScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("no Route Found"),
        ),
        body: const Center(
          child: Text("no Route Found"),
        ),
      ),
    );
  }
}
