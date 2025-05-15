import 'package:alraaqi_app/features/athkar/controller/athkar_controller.dart';
import 'package:alraaqi_app/features/athkar/view/screen/saved_athkar.dart';
import 'package:alraaqi_app/features/athkar/view/screen/youtube_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alraaqi_app/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AzkarEvning extends StatelessWidget {
  const AzkarEvning({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AthkarController());
    return Directionality(
      textDirection: controller.appSettingsPrefs.getLocale() == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: ColorCode.backgroundColor,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => SavedAzkarScreen(
                        isMorning: false,
                      ));
                },
                icon: Icon(Icons.favorite))
          ],
          backgroundColor: ColorCode.mainColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "أذكار المساء",
            style: TextStyle(
                fontFamily: "Noor",
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<AthkarController>(
            builder: (controller) => controller.status
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: GridView.builder(
                          itemCount: controller.eveningVideos.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 12.h,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            final video = controller.eveningVideos[index];
                            final videoId = video["videoId"]!;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => YouTubePlayerScreen(
                                      videoId: videoId,
                                      title: video["title"]!,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      spreadRadius: 1,
                                      blurRadius: 8,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: Image.network(
                                        YoutubePlayer.getThumbnail(
                                            videoId: videoId),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 150.h,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.network(
                                            'https://i.ytimg.com/vi/SgW-W3AIlwY/maxresdefault.jpg', // ضع صورة افتراضية في مجلد الصور
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 150.h,
                                          );
                                        },
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            video["title"]!,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "Noor",
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              controller.toggleFavorite(videoId,
                                                  isMorning: false);
                                            },
                                            icon: Icon(
                                              controller.eveningFavorites
                                                      .contains(videoId)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.asset(
                            "assets/images/adkar_masa.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                          .firstMatch(controller.position.value)
                                          ?.group(1) ??
                                      controller.position.value,
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.black),
                                ),
                                Expanded(
                                  child: Slider(
                                    thumbColor: ColorCode.secondaryColor,
                                    value: controller.value.value,
                                    min: 0,
                                    max: controller.max.value + 1,
                                    inactiveColor: Colors.grey.shade300,
                                    activeColor: ColorCode.mainColor,
                                    onChanged: (val) {
                                      controller
                                          .changeDurationToSeconds(val.toInt());
                                    },
                                  ),
                                ),
                                Text(
                                  RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                          .firstMatch(controller.duration.value)
                                          ?.group(1) ??
                                      controller.duration.value,
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Transform.scale(
                            scale: 1.5,
                            child: Obx(
                              () => IconButton(
                                onPressed: () {
                                  controller.playSound("sounds/azkar_2.mp3");
                                },
                                icon: controller.isPlaying.value
                                    ? const Icon(CupertinoIcons.pause_fill,
                                        color: ColorCode.secondaryColor)
                                    : const Icon(CupertinoIcons.play_fill,
                                        color: ColorCode.mainColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
