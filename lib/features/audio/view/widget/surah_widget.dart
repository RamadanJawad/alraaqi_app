import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/data/data.dart';
import 'package:alraaqi_app/features/audio/controller/audio_controller.dart';
import 'package:alraaqi_app/features/audio/view/widget/play_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SurahWidget extends StatelessWidget {
  const SurahWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(builder: (controller) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          ListView.builder(
              itemCount: Data().surahs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    controller.changeName(index);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
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
                        borderRadius: BorderRadius.circular(10.r)),
                    child: ListTile(
                      title: Text(
                        Data().surahs[index],
                        style: TextStyle(
                            fontFamily: "Noor",
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                      leading: Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Icon(
                          CupertinoIcons.play_fill,
                          color: ColorCode.mainColor,
                          size: 20,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          controller.favoriteAudio.any((fav) =>
                                  fav['surahUrl'] ==
                                  "${controller.url}${Data.surah_number[index]}.mp3")
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: controller.favoriteAudio.any((fav) =>
                                  fav['surahUrl'] ==
                                  "${controller.url}${Data.surah_number[index]}.mp3")
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          controller.surah_name = Data().surahs[index];
                          controller.id = Data.surah_number[index];
                          controller.surah_url =
                              "${controller.url}${controller.id}.mp3";
                          controller.marge =
                              "${controller.name}-${controller.surah_name}.mp3";
                          if (controller.favoriteAudio.any((fav) =>
                              fav['surahUrl'] == controller.surah_url)) {
                            controller
                                .removeFromFavorites(controller.surah_url);
                          } else {
                            controller.addToFavorites();
                          }
                        },
                      ),
                    ),
                  ),
                );
              }),
          controller.isShow.value ? const PlayTool() : const SizedBox.shrink()
        ],
      );
    });
  }
}
