import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/data/data.dart';
import 'package:alraaqi_app/features/athkar/controller/athkar_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class BodyAthkar extends StatelessWidget {
  const BodyAthkar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AthkarController>(builder: (controller) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        child: AnimationLimiter(
          child: ListView.builder(
            itemCount: Data.azkar.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.r),
                                topRight: Radius.circular(10.r),
                              ),
                              child: Image.asset(
                                Data.azkar[index]['image_url'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Obx(
                              () => Row(
                                children: [
                                  Text(
                                    controller.playingIndex.value == index
                                        ? RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                                .firstMatch(
                                                    controller.position.value)
                                                ?.group(1) ??
                                            controller.position.value
                                        : "00:00",
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.black),
                                  ),
                                  Expanded(
                                    child: Slider(
                                      thumbColor: ColorCode.secondaryColor,
                                      value:
                                          controller.playingIndex.value == index
                                              ? controller.value.value
                                              : 0,
                                      min: 0,
                                      max:
                                          controller.playingIndex.value == index
                                              ? controller.max.value + 1
                                              : 1.0,
                                      inactiveColor: Colors.grey.shade300,
                                      activeColor: ColorCode.mainColor,
                                      onChanged: (val) {
                                        controller.changeDurationToSeconds(
                                            val.toInt());
                                      },
                                    ),
                                  ),
                                  Text(
                                    controller.playingIndex.value == index
                                        ? RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                                .firstMatch(
                                                    controller.duration.value)
                                                ?.group(1) ??
                                            controller.duration.value
                                        : "00:00",
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: IconButton(
                                    onPressed: () {
                                      controller.playSound(
                                        index,
                                        Data.azkar[index]['sound_url'],
                                      );
                                    },
                                    icon: (controller.playingIndex.value ==
                                                index &&
                                            controller.isPlaying.value)
                                        ? const Icon(
                                            CupertinoIcons.pause_fill,
                                            color: ColorCode.secondaryColor,
                                          )
                                        : const Icon(
                                            CupertinoIcons.play_fill,
                                            color: ColorCode.mainColor,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
