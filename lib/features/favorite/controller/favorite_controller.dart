import 'dart:convert';
import 'package:alraaqi_app/core/cache/dependency_injection.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteController extends GetxController {
  SharedPrefController appSettingsPrefs = instance<SharedPrefController>();
  RxList<Map<String, String>> favoriteItems = <Map<String, String>>[].obs;

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favs = prefs.getStringList('favorites_roqia');
    if (favs != null) {
      favoriteItems.value = favs
          .map((e) => Map<String, String>.from(jsonDecode(e)))
          .toList();
    }
  }

  Future<void> removeFromFavorites(String title, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favoriteItems.removeWhere(
        (item) => item['title'] == title && item['name'] == name);
    prefs.setStringList(
        'favorites_roqia', favoriteItems.map((e) => jsonEncode(e)).toList());
  }
}
