import 'package:alraaqi_app/core/functions/check_internet.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AthkarController extends GetxController {
  AudioPlayer player = AudioPlayer();
  var isPlaying = false.obs;
  var duration = ''.obs;
  var max = 0.0.obs;
  var value = 0.0.obs;
  var position = ''.obs;
  bool status = false;
  late String vedioId;
  late YoutubePlayerController playerController;
  List data = [];

  Set<String> morningFavorites = <String>{}.obs;
  Set<String> eveningFavorites = <String>{}.obs;

  Future<void> toggleFavorite(String videoId, {required bool isMorning}) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = isMorning ? morningFavorites : eveningFavorites;

    if (favorites.contains(videoId)) {
      favorites.remove(videoId);
    } else {
      favorites.add(videoId);
    }

    await prefs.setStringList(
      isMorning ? 'favorites_morning' : 'favorites_evening',
      favorites.toList(),
    );
    update();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    morningFavorites =
        (prefs.getStringList('favorites_morning') ?? []).toSet().obs;
    eveningFavorites =
        (prefs.getStringList('favorites_evening') ?? []).toSet().obs;
    update();
  }

  final List<Map<String, String>> morningVideos = [
    {"title": "مشاري العفاسي", "videoId": "OIWahnI8rSI"},
    {"title": "إدريس أبكر", "videoId": "4ZjqVxoorNs"},
    {"title": "أحمد النفيس", "videoId": "fD4uDIoCn3M"},
    {"title": "عبدالكريم مهيوب", "videoId": "-wxIqA1u0jo"},
    {"title": "غسان الشوربجي", "videoId": "bmLrnBEC9_Y"},
    {"title": "سعد الغامدي", "videoId": "kswt7zgZFSs"},
  ];

  final List<Map<String, String>> eveningVideos = [
    {"title": "مشاري العفاسي", "videoId": "TGtdZmxsM5Q"},
    {"title": "إدريس أبكر", "videoId": "yJf_SD5Zl_8"},
    {"title": "أحمد النفيس", "videoId": "rQnNno3Do60"},
    {"title": "عبدالكريم مهيوب", "videoId": "WZ3gvlbQrMs"},
    {"title": "غسان ابو خضرة", "videoId": "ErNahkd8cNM"},
    {"title": "سعد الغامدي", "videoId": "kswt7zgZFSs"},
  ];

  // Get favorites based on type
  List<Map<String, String>> getFavoriteVideos(bool isMorning) {
    final favorites = isMorning ? morningFavorites : eveningFavorites;
    final videos = isMorning ? morningVideos : eveningVideos;

    return videos
        .where((video) => favorites.contains(video['videoId']))
        .toList();
  }

  checkStatus() async {
    status = await checkInternet();
    update();
  }

  @override
  void onInit() {
    checkStatus();
    super.onInit();
    loadFavorites();
    updatePosition();
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

  void changeDurationToSeconds(int second) {
    player.seek(Duration(seconds: second));
  }

  Future<void> playSound(String soundUrl) async {
    await player.setAudioSource(AudioSource.asset("asset:///$soundUrl"));
    if (isPlaying.value) {
      await player.pause();
      isPlaying.value = false;
    } else {
      await player.play();
      isPlaying.value = true;
    }
  }
}
