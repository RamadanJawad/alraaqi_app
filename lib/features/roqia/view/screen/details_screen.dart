import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/features/roqia/controller/roqia_controller.dart';
import 'package:alraaqi_app/features/roqia/view/widget/play_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final List<Map<String, String>> items;

  const DetailScreen({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RoqiaController());
    return Directionality(
      textDirection: controller.appSettingsPrefs.getLocale() == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: ColorCode.backgroundColor,
        appBar: AppBar(
          backgroundColor: ColorCode.mainColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            title,
            style: TextStyle(
                fontFamily: "Noor",
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<RoqiaController>(builder: (controller) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 70.h),
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.08),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return InkWell(
                      onTap: () {
                        controller.playSound(item['sound']!, item['name']!);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 4.h),
                        width: double.infinity,
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
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.asset(
                                "assets/images/roqia.jpeg",
                                width: double.infinity,
                                fit: BoxFit.fill,
                                height: 90.h,
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Text(
                                textAlign: TextAlign.center,
                                item['name']!,
                                maxLines: 2,
                                style: TextStyle(
                                    fontFamily: "Noor",
                                    fontSize: 14.sp,
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              leading: IconButton(
                                onPressed: () {
                                  controller.toggleFavorite(
                                      title, item['name']!);
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: controller.isFavorite(
                                          title, item['name']!)
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Obx(() {
                if (controller.isShow.value) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: PlayToolRoqia(),
                  );
                } else {
                  return SizedBox.shrink(); // لا شيء إذا لم يكن الشريط مفعّلًا
                }
              }),
            ],
          );
        }),
      ),
    );
  }
}
