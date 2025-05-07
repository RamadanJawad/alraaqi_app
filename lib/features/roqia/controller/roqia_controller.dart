import 'package:alraaqi_app/core/functions/check_internet.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class RoqiaController extends GetxController {
  List item = [];
  AudioPlayer player = AudioPlayer();
  var isPlaying = false.obs;
  var duration = ''.obs;
  var max = 0.0.obs;
  var value = 0.0.obs;
  var position = ''.obs;
  bool status = false;
  int seconds = 0;

  Set<int> favoriteIndices = Set();
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favs = prefs.getStringList('favorites_roqia');
    if (favs != null) {
      favoriteIndices = favs.map((e) => int.parse(e)).toSet();
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

  Future<void> toggleFavorite(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (favoriteIndices.contains(index)) {
      favoriteIndices.remove(index);
    } else {
      favoriteIndices.add(index);
    }
    prefs.setStringList(
        'favorites_roqia', favoriteIndices.map((e) => e.toString()).toList());
    update();
  }

  checkStatus() async {
    status = await checkInternet();
    update();
  }

  final List<Map<String, dynamic>> mainItems = [
    {
      'title': 'الرقية الشرعية',
      'items': [
        {"name": 'سورة الفاتحة ٧ مرات', "sound": "sounds/tahseen3.mp3"},
        {"name": 'تحصين النفس', "sound": "sounds/tahseen1.mp3"},
        {"name": 'الحصن الشامل', "sound": "sounds/tahseen2.mp3"},
        {"name": 'الرقية الشرعية القصيرة', "sound": "sounds/tahseen4.mp3"},
        {"name": 'رقية السحر والعين والنفس', "sound": "sounds/roqia3.mp3"},
        {"name": 'رقية لتحصين النفس', "sound": "sounds/roqia1.mp3"},
        {"name": 'رقية للشفاء الجسدي', "sound": "sounds/roqia2.mp3"},
      ]
    },
    {
      'title': 'الرقية العلاجية',
      'items': [
        {"name": 'رقية السحر والعين والنفس', "sound": "sounds/roqia3.mp3"},
        {"name": 'رقية لتحصين النفس', "sound": "sounds/roqia1.mp3"},
        {"name": 'رقية للشفاء الجسدي', "sound": "sounds/roqia2.mp3"},
      ]
    },
    {
      'title': 'التحصينات اليومية',
      'items': [
        {"name": 'سورة الفاتحة ٧ مرات', "sound": "sounds/tahseen3.mp3"},
        {"name": 'تحصين النفس', "sound": "sounds/tahseen1.mp3"},
        {"name": 'الحصن الشامل', "sound": "sounds/tahseen2.mp3"},
        {"name": 'الرقية الشرعية القصيرة', "sound": "sounds/tahseen4.mp3"},
      ]
    },
  ];

  @override
  void onInit() {
    checkStatus();
    super.onInit();
    updatePosition();
    loadFavorites();
  }

  void _vibrate() async {
    Vibration.vibrate(duration: 500); // هز لمدة 300 ملي ثانية
  }

  void changeDurationToSeconds(int second) {
    player.seek(Duration(seconds: second));
  }

  Future<void> playSound(String soundUrl) async {
    await player.setAudioSource(AudioSource.asset("assets/$soundUrl"));
    if (isPlaying.value) {
      await player.pause();
      isPlaying.value = false;
    } else {
      _vibrate();
      await player.play();
      isPlaying.value = true;
    }
  }
}
