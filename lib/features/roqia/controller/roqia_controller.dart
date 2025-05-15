import 'dart:convert';

import 'package:alraaqi_app/core/cache/dependency_injection.dart';
import 'package:alraaqi_app/core/constant/manager_strings.dart';
import 'package:alraaqi_app/core/functions/check_internet.dart';
import 'package:alraaqi_app/core/functions/convert_image.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoqiaController extends GetxController {
  List item = [];
  AudioPlayer player = AudioPlayer();
  var isPlaying = false.obs;
  var duration = ''.obs;
  SharedPrefController appSettingsPrefs = instance<SharedPrefController>();
  var max = 0.0.obs;
  var isShow = false.obs;
  var value = 0.0.obs;
  var position = ''.obs;
  bool status = false;
  int seconds = 0;
  String? currentlyPlaying;
  String? currentRoqiaName;
  Set<String> favoriteItems = {};

  disposeAndClosePlayTool() {
    player.stop();
    isShow.value = false;
    update();
  }

  void playSound(String path, String name) async {
    if (currentlyPlaying == path) {
      currentlyPlaying = null;
      currentRoqiaName = null;
      await player.stop();
      update();
    } else {
      currentlyPlaying = path;
      currentRoqiaName = name;
      Uri artUri =
          await getAssetImageFileUri("assets/images/roqia.jpeg", "roqia.jpeg");
      await player.setAudioSource(
        AudioSource.asset(
          "assets/$path",
          tag: MediaItem(
            id: "roqia_id",
            title: name,
            album: name,
            playable: true,
            artUri: artUri,
          ),
        ),
      );
      isShow(true);
      await player.play();
      updatePosition();
    }
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favs = prefs.getStringList('favorites_roqia');
    if (favs != null) {
      favoriteItems = (favs ?? []).toSet();
      update();
    }
  }

  updatePosition() {
    player.durationStream.listen((d) {
      duration.value = d.toString();
      max.value = d!.inSeconds.toDouble();
    });
    player.positionStream.listen((p) {
      position.value = p.toString();
      value.value = p.inSeconds.toDouble();
    });
  }

  Future<void> toggleFavorite(String title, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String favItem = jsonEncode({"title": title, "name": name});
    if (favoriteItems.contains(favItem)) {
      favoriteItems.remove(favItem);
    } else {
      favoriteItems.add(favItem);
    }
    await prefs.setStringList('favorites_roqia', favoriteItems.toList());
    update();
  }

  bool isFavorite(String title, String name) {
    String favItem = jsonEncode({"title": title, "name": name});
    return favoriteItems.contains(favItem);
  }

  checkStatus() async {
    status = await checkInternet();
    update();
  }

  List<Map<String, dynamic>> get mainItems => [
        {
          'title': ManagerStrings.ruqyahShariah,
          'items': [
            {"name": 'سورة الفاتحة ٧ مرات', "sound": "sounds/tahseen3.mp3"},
            {
              "name": 'رقية لتحصين النفس من كل شر',
              "sound": "sounds/roqia1.mp3"
            },
            {"name": 'رقية شرعية مختصرة', "sound": "sounds/roq4.mp3"},
            {"name": 'رقية شرعية قوية شاملة', "sound": "sounds/roq5.mp3"},
            {
              "name": 'رقية شرعية كاملة ناصر القطامي',
              "sound": "sounds/roq7.mp3"
            },
            {
              "name": 'رقية شرعية كاملة محمد هاشم',
              "sound": "sounds/roq8.mp3"
            }
          ]
        },
        {
          'title': ManagerStrings.ruqyahHealing,
          'items': [
            {"name": 'رقية السحر والعين والنفس', "sound": "sounds/roqia3.mp3"},
            {"name": 'رقية للشفاء الجسدي', "sound": "sounds/roqia2.mp3"},
            {"name": 'آيات الشفاء', "sound": "sounds/roq2.mp3"},
            {"name": 'رقية علاجية قوية مختصرة', "sound": "sounds/roq1.mp3"},
          ]
        },
        {
          'title': ManagerStrings.dailyProtections,
          'items': [
            {
              "name": 'تحصين النفس,أية الكرسي والمعوذات',
              "sound": "sounds/tahseen1.mp3"
            },
            {"name": 'الحصن الشامل لأبي الحسن', "sound": "sounds/tahseen2.mp3"},
            {"name": 'الرقية اليومية القصيرة', "sound": "sounds/tahseen4.mp3"},
            {"name": 'تحصين البيت والنفس', "sound": "sounds/tah2.mp3"},
            {"name": 'دعاء التحصين', "sound": "sounds/tah1.mp3"},
          ]
        },
      ];

  @override
  void onInit() {
    checkStatus();
    super.onInit();
    loadFavorites();
  }

  void changeDurationToSeconds(int second) {
    player.seek(Duration(seconds: second));
  }
}
