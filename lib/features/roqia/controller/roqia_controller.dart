import 'dart:convert';
import 'package:alraaqi_app/core/cache/dependency_injection.dart';
import 'package:alraaqi_app/core/constant/manager_strings.dart';
import 'package:alraaqi_app/core/functions/check_internet.dart';
import 'package:alraaqi_app/core/functions/convert_image.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
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

  void playSound(String path, String name, String imagePath) async {
    if (currentlyPlaying == path) {
      currentlyPlaying = null;
      currentRoqiaName = null;
      await player.stop();
      update();
    } else {
      currentlyPlaying = path;
      currentRoqiaName = name;
      Uri artUri =
          await getAssetImageFileUri(imagePath, imagePath.split('/').last);
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
      _showNotification(
        id: 1,
        title: 'تشغيل الصوت',
        body: 'تم بدء تشغيل: $name',
      );
      player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _showNotification(
            id: 2,
            title: 'انتهاء الصوت',
            body: 'انتهى تشغيل: $name',
          );
          isShow(false);
          update();
        }
      });

      // مباشرة بعد تعيين مصدر الصوت، جلب المدة
      final d = player.duration;
      if (d != null) {
        duration.value = _formatDuration(d);
        max.value = d.inSeconds.toDouble();
      }

      // استماع لتغيرات المدة لاحقًا (يمكن إبقاؤه أو حذفه إذا كان لديك في مكان آخر)
      player.durationStream.listen((d) {
        if (d != null) {
          duration.value = _formatDuration(d);
          max.value = d.inSeconds.toDouble();
        }
      });

      await player.play();
      updatePosition();
    }
  }

  void _showNotification(
      {required int id, required String title, required String body}) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'audio_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  String formatDuration(Duration? duration) {
    if (duration == null) return "0:00";
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favs = prefs.getStringList('favorites_roqia');
    if (favs != null) {
      favoriteItems = (favs).toSet();
      update();
    }
  }

  updatePosition() {
    player.durationStream.listen((d) {
      if (d != null) {
        duration.value = _formatDuration(d);
        max.value = d.inSeconds.toDouble();
      }
    });
    player.positionStream.listen((p) {
      position.value = _formatDuration(p);
      value.value = p.inSeconds.toDouble();
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
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
          'imageUrl': 'assets/images/image1.jpeg',
          'items': [
            {
              "name": ManagerStrings.surahFatiha7Times,
              "sound": "sounds/tahseen3.mp3",
              'imageUrl': 'assets/images/image1.jpeg',
            },
            {
              "name": ManagerStrings.selfProtectionRuqyah,
              "sound": "sounds/roqia1.mp3",
              'imageUrl': 'assets/images/image1.jpeg',
            },
            {
              "name": ManagerStrings.shortRuqyah,
              "sound": "sounds/roq4.mp3",
              'imageUrl': 'assets/images/image1.jpeg',
            },
            {
              "name": ManagerStrings.powerfulRuqyah,
              "sound": "sounds/roq5.mp3",
              'imageUrl': 'assets/images/image1.jpeg',
            },
            {
              "name": ManagerStrings.fullRuqyahQatami,
              "sound": "sounds/roq7.mp3",
              'imageUrl': 'assets/images/image1.jpeg',
            },
            {
              "name": ManagerStrings.fullRuqyahHashim,
              "sound": "sounds/roq8.mp3",
              'imageUrl': 'assets/images/image1.jpeg',
            },
          ]
        },
        {
          'title': ManagerStrings.ruqyahHealing,
          'imageUrl': 'assets/images/image2.jpeg',
          'items': [
            {
              "name": ManagerStrings.ruqyahAgainstMagic,
              "sound": "sounds/roqia3.mp3",
              'imageUrl': 'assets/images/image2.jpeg',
            },
            {
              "name": ManagerStrings.physicalHealingRuqyah,
              "sound": "sounds/roqia2.mp3",
              'imageUrl': 'assets/images/image2.jpeg',
            },
            {
              "name": ManagerStrings.healingVerses,
              "sound": "sounds/roq2.mp3",
              'imageUrl': 'assets/images/image2.jpeg',
            },
            {
              "name": ManagerStrings.shortPowerfulHealing,
              "sound": "sounds/roq1.mp3",
              'imageUrl': 'assets/images/image2.jpeg',
            },
          ]
        },
        {
          'title': ManagerStrings.dailyProtections,
          'imageUrl': 'assets/images/image3.jpeg',
          'items': [
            {
              "name": ManagerStrings.ayahKursiAndMuawidhat,
              "sound": "sounds/tahseen1.mp3",
              'imageUrl': 'assets/images/image3.jpeg',
            },
            {
              "name": ManagerStrings.abuHasanFortress,
              "sound": "sounds/tahseen2.mp3",
              'imageUrl': 'assets/images/image3.jpeg',
            },
            {
              "name": ManagerStrings.shortDailyRuqyah,
              "sound": "sounds/tahseen4.mp3",
              'imageUrl': 'assets/images/image3.jpeg',
            },
            {
              "name": ManagerStrings.homeAndSelfProtection,
              "sound": "sounds/tah2.mp3",
              'imageUrl': 'assets/images/image3.jpeg',
            },
            {
              "name": ManagerStrings.protectionDua,
              "sound": "sounds/tah1.mp3",
              'imageUrl': 'assets/images/image3.jpeg',
            },
          ]
        },
      ];

  @override
  void onInit() {
    checkStatus();
    super.onInit();
    loadFavorites();
    updatePosition();
  }

  void changeDurationToSeconds(int second) {
    player.seek(Duration(seconds: second));
  }
}
