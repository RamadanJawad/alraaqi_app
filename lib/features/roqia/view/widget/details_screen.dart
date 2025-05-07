import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/functions/convert_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final List<Map<String, String>> items;

  const DetailScreen({required this.title, required this.items});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentlyPlaying;

  void _playSound(String path) async {
    if (_currentlyPlaying == path) {
      setState(() {
        _currentlyPlaying = null;
      });
      await _audioPlayer.stop();
    } else {
      setState(() {
        _currentlyPlaying = path;
      });

      Uri artUri =
          await getAssetImageFileUri("assets/images/roqia.jpeg", "roqia.jpeg");
      await _audioPlayer.setAudioSource(
        AudioSource.asset(
          "assets/$path",
          tag: MediaItem(
            id: "roqia_id",
            title: widget.title,
            album: widget.title,
            playable: true,
            artUri: artUri,
          ),
        ),
      );
      await _audioPlayer.play();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorCode.backgroundColor,
        appBar: AppBar(
          backgroundColor: ColorCode.mainColor,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.favorite))],
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.title,
            style: TextStyle(
                fontFamily: "Noor",
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return InkWell(
              onTap: () {
                _playSound(item['sound']!);
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                width: double.infinity,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200]!,
                        offset: const Offset(0, 10),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  trailing: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Icon(
                      _currentlyPlaying == item['sound']
                          ? Icons.pause_circle
                          : Icons.play_circle,
                      size: 30,
                    ),
                  ),
                  title: Text(item['name']!,
                      style: TextStyle(
                          fontFamily: "Noor",
                          fontSize: 18.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.right),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
