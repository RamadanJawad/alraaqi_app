import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/features/audio/controller/audio_controller.dart';
import 'package:alraaqi_app/features/roqia/controller/roqia_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class PlayToolRoqia extends StatelessWidget {
  const PlayToolRoqia({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoqiaController>(builder: (controller) {
      return Container(
        width: double.infinity,
        height: 75.h,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.teal.shade700,
            borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
          child: Row(
            children: [
              Container(
                width: 34.w,
                height: 34.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: IconButton(
                  onPressed: () async {
                    controller.disposeAndClosePlayTool();
                  },
                  icon: Icon(
                    CupertinoIcons.clear,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              SizedBox(
                width: 5.w,
              ),
              Obx(
                () => Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.currentRoqiaName ?? "",
                        style: TextStyle(
                            fontFamily: "Noor",
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            controller.position.value,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Slider(
                              thumbColor: Colors.black,
                              value: controller.value.value,
                              min: 0,
                              max: controller.max.value + 1,
                              inactiveColor: Colors.grey,
                              activeColor: Colors.black54,
                              onChanged: (val) {
                                controller.changeDurationToSeconds(val.toInt());
                              },
                            ),
                          ),
                          Text(
                            controller.duration.value,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
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
                              index: controller.player.effectiveIndices!.first);
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
      );
    });
  }
}
