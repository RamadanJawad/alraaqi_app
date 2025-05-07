import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/constant/image_url.dart';
import 'package:alraaqi_app/core/data/data.dart';
import 'package:alraaqi_app/features/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class AyhaWidget extends StatelessWidget {
  const AyhaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 5),
                  ),
                ],
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16.r)),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      ImageUrl.icon,
                      width: 23.w,
                      height: 23.h,
                    ),
                    Text("أية وعبرة",
                        style: TextStyle(
                          fontFamily: "Noor",
                          fontSize: 20.sp,
                          color: ColorCode.secondaryColor,
                          fontWeight: FontWeight.bold,
                        )),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text:
                                  "${controller.ayha(controller.currentPage)}\n ${controller.tafseer(controller.currentPage)}"));
                          Get.showSnackbar(const GetSnackBar(
                            backgroundColor: ColorCode.mainColor,
                            messageText: Text(
                              "تم نسخ النص بنجاح ",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Cairo",
                                  fontSize: 16),
                            ),
                            duration: Duration(seconds: 2),
                          ));
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.grey,
                        )),
                    IconButton(
                        onPressed: () async {
                          await Share.share(
                              controller.share(controller.currentPage));
                        },
                        icon: const Icon(
                          Icons.share,
                          color: Colors.grey,
                        )),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 130.h,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: ColorCode.mainColor),
                  child: PageView.builder(
                    scrollBehavior: const ScrollBehavior(),
                    controller: controller.pageController,
                    onPageChanged: (index) {
                      controller.onPageChange(index);
                    },
                    itemCount: Data.ayah.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Center(
                            child: Text(
                              "۞ ${controller.ayha(index)} ۞",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Noor",
                                  fontSize: 18.sp,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Center(
                            child: Text(
                              controller.tafseer(index),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Noor",
                                  fontSize: 14.sp,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ));
      },
    );
  }
}
