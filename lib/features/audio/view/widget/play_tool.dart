import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/features/audio/controller/audio_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class PlayTool extends StatelessWidget {
  const PlayTool({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(builder: (controller) {
      return Container(
        width: double.infinity,
        height: 60.h,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.teal.shade700,
            borderRadius: BorderRadius.circular(20.r)),
        child: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    controller.image,
                    width: 50.w,
                    fit: BoxFit.cover,
                    height: 48.h,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontFamily: "Noor",
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                          children: [
                            TextSpan(text: "${controller.name} "),
                            TextSpan(text: controller.surah_name),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          thumbColor: Colors.black,
                          value: controller.value.value,
                          min: const Duration(seconds: 0).inSeconds.toDouble(),
                          max: controller.max.value + 1,
                          inactiveColor: Colors.grey,
                          activeColor: Colors.black54,
                          onChanged: (val) {
                            controller.changeDurationToSeconds(val.toInt());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: IconButton(
                    onPressed: () {
                      controller.skip();
                    },
                    icon: Icon(
                      CupertinoIcons.arrow_right_to_line,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 6.w,
                ),
                StreamBuilder<PlayerState>(
                  stream: controller.player.playerStateStream,
                  builder: (context, snapshot) {
                    final playerState = snapshot.data;
                    final processingState = playerState?.processingState;
                    final playing = playerState?.playing;
                    if (processingState == ProcessingState.loading ||
                        processingState == ProcessingState.buffering) {
                      return Container(
                        width: 36.w,
                        height: 36.h,
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      );
                    } else if (playing != true) {
                      return Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: playing ?? true ? Colors.red : Colors.black,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            controller.player.play();
                          },
                          icon: Icon(
                            CupertinoIcons.play_fill,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      );
                    } else if (processingState != ProcessingState.completed) {
                      return Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: playing! ? Colors.red : ColorCode.mainColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            controller.player.pause();
                          },
                          icon: Icon(
                            CupertinoIcons.pause_fill,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            controller.player.seek(Duration.zero,
                                index:
                                    controller.player.effectiveIndices!.first);
                          },
                          icon: Icon(
                            CupertinoIcons.reply,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
