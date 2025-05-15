import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/constant/image_url.dart';
import 'package:alraaqi_app/core/constant/manager_strings.dart';
import 'package:alraaqi_app/features/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:share_plus/share_plus.dart';

class HadeesWidget extends StatelessWidget {
  const HadeesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  ImageUrl.icon,
                  width: 23.w,
                  height: 23.w,
                ),
                Text(
                  ManagerStrings.todaysDua,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Noor",
                      color: ColorCode.secondaryColor),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: "دعاء اليوم\n ${controller.dua}"));
                    Get.showSnackbar(GetSnackBar(
                      backgroundColor: ColorCode.mainColor,
                      messageText: Text(
                        ManagerStrings.copyText,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Noor",
                            fontSize: 16.sp),
                      ),
                      duration: Duration(seconds: 2),
                    ));
                  },
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                IconButton(
                  onPressed: () async {
                    await Share.share(controller.dua);
                  },
                  icon: const Icon(
                    Icons.share,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: ColorCode.mainColor),
              child: Text(
                "${controller.dua}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Noor", fontSize: 19.sp, color: Colors.white),
              ),
            )
          ],
        ),
      );
    });
  }
}
