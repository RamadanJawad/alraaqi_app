// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alraaqi_app/core/constant/color.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:alraaqi_app/features/roqia/controller/roqia_controller.dart';

class BodyRoqia extends StatelessWidget {
  const BodyRoqia({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoqiaController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.asset(
                "assets/images/roqia.jpeg",
                width: double.infinity,
                height: 300.h,
                fit: BoxFit.cover,
              ),
            ),
            Obx(
              () => Row(
                children: [
                  Text(
                    RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                            .firstMatch(controller.position.value)
                            ?.group(1) ??
                        controller.position.value,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                  Expanded(
                    child: Slider(
                      thumbColor: ColorCode.secondaryColor,
                      value: controller.value.value,
                      min: const Duration(seconds: 0).inSeconds.toDouble(),
                      max: controller.max.value + 1,
                      inactiveColor: Colors.grey.shade300,
                      activeColor: ColorCode.mainColor,
                      onChanged: (val) {
                        controller.changeDurationToSeconds(val.toInt());
                      },
                    ),
                  ),
                  Text(
                    RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                            .firstMatch(controller.duration.value)
                            ?.group(1) ??
                        controller.duration.value,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                ],
              ),
            ),
            Obx(() => Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Transform.scale(
                    scale: 1.5,
                    child: IconButton(
                      onPressed: () {
                        controller.togglePlayPause();
                      },
                      icon: controller.isPlaying.value
                          ? const Icon(CupertinoIcons.pause_fill,
                              color: ColorCode.secondaryColor)
                          : const Icon(CupertinoIcons.play_fill,
                              color: ColorCode.mainColor),
                    ),
                  ),
                )),
          ],
        ),
      );
    });
  }
}
