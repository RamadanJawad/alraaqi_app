import 'dart:io';
import 'package:alraaqi_app/core/data/data.dart';
import 'package:alraaqi_app/core/functions/convert_image.dart';
import 'package:alraaqi_app/features/audio/view/screen/surah_screen.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioController extends GetxController {
  bool isPlaying = false;
  AudioPlayer player = AudioPlayer();
  var duration = ''.obs;
  var position = ''.obs;
  var max = 0.0.obs;
  var value = 0.0.obs;
  var isShow = false.obs;
  BuildContext? context = Get.context!;
  bool isFound = false;
  bool isRepeatModeEnabled = false;
  bool isLoadingAudio = false;
  String? path_2;
  double progress = 0.0;
  int selectItem = 0;
  String name = "مشاري العفاسي";
  String id = "001";
  int seconds = 0;
  String image = "assets/images/masari.jpg";
  String surah_name = "سورة الفاتحة";
  String url = "https://server8.mp3quran.net/afs/";
  String surah_url = "https://server8.mp3quran.net/afs/001.mp3";
  bool status = true;
  int stepCounter = 0;
  String marge = "مشاري العفاسي-سورة الفاتحة.mp3";
  bool isBannerAd = false;
  bool isInterstitialAd = false;
  List<Map<String, String>> favoriteAudio = [];

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void removeFromFavorites(String url) {
    favoriteAudio.removeWhere((item) => item['surahUrl'] == url);
    saveFavorites();
    update();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = favoriteAudio.map((e) => e.toString()).toList();
    await prefs.setStringList('audioFavorites', favList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('audioFavorites') ?? [];
    favoriteAudio = favList.map((e) {
      final map = e
          .replaceAll(RegExp(r'[{}]'), '')
          .split(', ')
          .fold<Map<String, String>>({}, (map, pair) {
        final keyValue = pair.split(': ');
        map[keyValue[0]] = keyValue[1];
        return map;
      });
      return map;
    }).toList();
    update();
  }

  void addToFavorites() {
    final item = {
      'surahName': surah_name,
      'surahUrl': surah_url,
      'reciterName': name,
      'reciterImage': image,
    };

    if (!favoriteAudio.any((fav) => fav['surahUrl'] == item['surahUrl'])) {
      favoriteAudio.add(item);
      saveFavorites();
      update();
    }
  }

  changeIndex(int index) {
    selectItem = index;
    name = Data.reciters[index]['name2'];
    image = Data.reciters[index]['image'];
    url = Data.reciters[index]['url'];
    surah_url = "$url$id.mp3";
    Get.to(SurahScreen());
    update();
  }

  skip() {
    if (Data.surah_number[stepCounter] != "114") {
      stepCounter++;
      id = Data.surah_number[stepCounter];
      surah_name = Data().surahs[stepCounter];
      player.setAudioSource(
        AudioSource.uri(
          Uri.parse("$url$id.mp3"),
        ),
      );
      update();
    }
  }

  changeName(int index) {
    surah_name = Data().surahs[index];
    surah_url = "$url${Data.surah_number[index]}.mp3";
    id = Data.surah_number[index];
    marge = "$name-$surah_name.mp3";
    isShow(true);
    playSong();
    update();
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

  changeDurationToSeconds(second) {
    seconds = second;
    var duration = Duration(seconds: second);
    player.seek(duration);
  }

  Future<void> playSong() async {
    try {
      Uri artUri = await getAssetImageFileUri(image, image.split('/').last);

      await player.setAudioSource(
        AudioSource.uri(
          Uri.parse(surah_url),
          tag: MediaItem(
            id: id,
            title: surah_name,
            album: name,
            playable: true,
            artUri: artUri,
          ),
        ),
      );
      player.play();
      player.setVolume(1);
      updatePosition();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
