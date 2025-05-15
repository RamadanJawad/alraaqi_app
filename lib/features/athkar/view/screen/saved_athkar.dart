// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alraaqi_app/features/athkar/controller/athkar_controller.dart';
import 'package:alraaqi_app/features/athkar/view/screen/youtube_screen.dart';
import 'package:flutter/material.dart';
import 'package:alraaqi_app/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SavedAzkarScreen extends StatelessWidget {
  final bool isMorning; // نحدد من أين جاءت الشاشة
  const SavedAzkarScreen({super.key, required this.isMorning});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AthkarController());
    return Directionality(
      textDirection: controller.appSettingsPrefs.getLocale() == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorCode.mainColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "الأذكار المفضلة",
            style: TextStyle(
              fontFamily: "Noor",
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: GetBuilder<AthkarController>(
          builder: (controller) {
            final favs =
                controller.getFavoriteVideos(isMorning); // حسب نوع الأذكار
            if (favs.isEmpty) {
              return Center(
                child: Text(
                  'لا توجد عناصر مفضلة',
                  style: TextStyle(
                    fontFamily: "Noor",
                    fontSize: 20.sp,
                    color: ColorCode.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: favs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final item = favs[index];
                  final videoId = item['videoId']!;
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => YouTubePlayerScreen(
                            videoId: videoId,
                            title: item['title']!,
                          ));
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
                              YoutubePlayer.getThumbnail(videoId: videoId),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 150.h,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                  'https://i.ytimg.com/vi/pPYt9jZjbUE/maxresdefault.jpg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 150.h,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Text(
                              item['title']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Noor",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
