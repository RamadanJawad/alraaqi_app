import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RoqiaController extends GetxController {
  List item = [];
  var isPlaying = false.obs;
  AudioPlayer player = AudioPlayer();
  var duration = ''.obs;
  var max = 0.0.obs;
  var value = 0.0.obs;
  int seconds = 0;
  var position = ''.obs;

  @override
  void onInit() {
    super.onInit();
    readData();
    setupListeners();
    playSong();
  }

  Future<void> readData() async {
    String data = await rootBundle.loadString("assets/json/roqia.json");
    item = json.decode(data);
    update();
  }

  void setupListeners() {
    player.onDurationChanged.listen((Duration d) {
      duration.value = d.toString();
      max.value = d.inSeconds.toDouble();
    });

    player.onPositionChanged.listen((Duration p) {
      position.value = p.toString();
      value.value = p.inSeconds.toDouble();
    });

    player.onPlayerStateChanged.listen((PlayerState state) {
      isPlaying.value = state == PlayerState.playing;
    });
  }

  void changeDurationToSeconds(int second) {
    seconds = second;
    player.seek(Duration(seconds: second));
  }

  Future<void> playSong() async {
    try {
      await player.play(AssetSource('sounds/roqia.mp3'));
    } catch (e) {
      print("❌ خطأ في التشغيل: $e");
    }
  }

  void togglePlayPause() {
    if (isPlaying.value) {
      player.pause();
    } else {
      player.resume();
    }
  }
}