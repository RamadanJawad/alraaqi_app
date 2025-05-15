import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/constant/manager_strings.dart';
import 'package:alraaqi_app/features/favorite/controller/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
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
            ManagerStrings.favorite,
            style: TextStyle(
                fontFamily: "Noor",
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Obx(() {
          return controller.favoriteItems.isEmpty
              ? Center(
                  child: Text(
                    ManagerStrings.noFavorite,
                    style: TextStyle(fontSize: 16.sp, fontFamily: "Noor"),
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.only(bottom: 20.h),
                  itemCount: controller.favoriteItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.08),
                  itemBuilder: (context, index) {
                    final item = controller.favoriteItems[index];
                    return InkWell(
                      onTap: () {
                        controller.removeFromFavorites(
                            item['title']!, item['name']!);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 4.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white, // خلفية مميزة
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
                                item['name']!,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: "Noor",
                                  fontSize: 14.sp,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              leading: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        }),
      ),
    );
  }
}
