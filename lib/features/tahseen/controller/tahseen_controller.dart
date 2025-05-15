import 'package:alraaqi_app/core/cache/dependency_injection.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TahseenController extends GetxController {
  Set<int> favoriteIndices = Set();
  SharedPrefController appSettingsPrefs = instance<SharedPrefController>();
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favs = prefs.getStringList('favorites_tahseen');
    if (favs != null) {
      favoriteIndices = favs.map((e) => int.parse(e)).toSet();
      update();
    }
  }

  Future<void> toggleFavorite(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (favoriteIndices.contains(index)) {
      favoriteIndices.remove(index);
    } else {
      favoriteIndices.add(index);
    }
    prefs.setStringList(
        'favorites_tahseen', favoriteIndices.map((e) => e.toString()).toList());
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }
}
