import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/features/audio/controller/audio_controller.dart';
import 'package:alraaqi_app/features/audio/view/widget/play_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FavoriteAudio extends StatelessWidget {
  const FavoriteAudio({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: ColorCode.mainColor,
              elevation: 0,
              title: Text(
                "السور المفضلة",
                style: TextStyle(
                  fontFamily: "Noor",
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                controller.favoriteAudio.isEmpty
                    ? Center(
                        child: Text(
                          "لا توجد سور مفضلة حالياً",
                          style: TextStyle(
                            fontFamily: "Noor",
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.favoriteAudio.length,
                        itemBuilder: (context, index) {
                          final fav = controller.favoriteAudio[index];
                          return InkWell(
                            onTap: () {
                              controller.name = fav['reciterName']!;
                              controller.image = fav['reciterImage']!;
                              controller.surah_name = fav['surahName']!;
                              controller.surah_url = fav['surahUrl']!;
                              controller.marge =
                                  "${controller.name}-${controller.surah_name}.mp3";

                              controller.isShow(true);
                              controller.playSong(); // نجبر إعادة تحميل الصوت
                              controller.update();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 4.h),
                              width: double.infinity,
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[200]!,
                                    offset: const Offset(0, 10),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: ListTile(
                                title: Text(
                                  fav['surahName']!,
                                  style: TextStyle(
                                    fontFamily: "Noor",
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                leading: Container(
                                  width: 36.w,
                                  height: 36.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Icon(
                                    CupertinoIcons.play_fill,
                                    color: ColorCode.mainColor,
                                    size: 20,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    controller
                                        .removeFromFavorites(fav['surahUrl']!);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                controller.isShow.value
                    ? const PlayTool()
                    : const SizedBox.shrink()
              ],
            ),
          ),
        );
      },
    );
  }
}
