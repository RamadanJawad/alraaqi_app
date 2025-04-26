import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AthkarController extends GetxController {
  AudioPlayer player = AudioPlayer();
  var isPlaying = false.obs;
  var duration = ''.obs;
  var max = 0.0.obs;
  var value = 0.0.obs;
  var position = ''.obs;
  var playingIndex = (-1).obs;
  List data = [];

  @override
  void onInit() {
    super.onInit();
    setupListeners();
  }

  void setupListeners() {
    player.onDurationChanged.listen((d) {
      duration.value = d.toString();
      max.value = d.inSeconds.toDouble();
    });

    player.onPositionChanged.listen((p) {
      position.value = p.toString();
      value.value = p.inSeconds.toDouble();
    });

    player.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });
  }

  void changeDurationToSeconds(int second) {
    player.seek(Duration(seconds: second));
  }

  Future<void> playSound(int index, String soundUrl) async {
    if (playingIndex.value == index && isPlaying.value) {
      await player.pause();
      playingIndex.value = -1;
      return;
    }
    await player.stop();
    await player.play(AssetSource(soundUrl));
    playingIndex.value = index;
  }
}
