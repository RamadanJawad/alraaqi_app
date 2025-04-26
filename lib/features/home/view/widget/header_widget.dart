import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/constant/image_url.dart';
import 'package:alraaqi_app/features/home/view/widget/icon_widget.dart';
import 'package:alraaqi_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200.h,
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                ColorCode.mainColor,
                Colors.white,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(30).r,
                  bottomRight: const Radius.circular(30).r)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 35.h, left: 10.w, right: 10.w),
          child: Opacity(
            opacity: 0.6,
            child: Image.asset(ImageUrl.mosque),
          ),
        ),
        Container(
          width: double.infinity,
          margin:
              const EdgeInsets.only(top: 120, left: 10, right: 10, bottom: 3),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20).r,
                topRight: const Radius.circular(20).r,
                bottomLeft: const Radius.circular(5).r,
                bottomRight: const Radius.circular(5).r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Image.asset(
                      ImageUrl.icon,
                      width: 25.w,
                      height: 25.h,
                    ),
                    Text(
                      "الاختصارات",
                      style: TextStyle(
                          fontFamily: "Noor",
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: ColorCode.secondaryColor),
                    )
                  ],
                ),
                const Divider(
                  endIndent: 6,
                  indent: 6,
                  thickness: 1,
                ),
                Row(
                  children: [
                    IconWidget(
                      urlAsset: ImageUrl.quran,
                      name: "القرآن",
                      onPressed: () {
                        Get.toNamed(Routes.quran);
                      },
                    ),
                    IconWidget(
                      urlAsset: ImageUrl.allah,
                      name: "الأذكار",
                      onPressed: () {
                        Get.toNamed(Routes.athkar);
                      },
                    ),
                    IconWidget(
                      urlAsset: ImageUrl.athkar,
                      name: "الرقية",
                      onPressed: () {
                        Get.toNamed(Routes.roqia);
                      },
                    ),
                    IconWidget(
                      urlAsset: ImageUrl.hadeas,
                      name: "التحصينات",
                      onPressed: () {
                        Get.toNamed(Routes.tahseen);
                      },
                    ),
                    IconWidget(
                      urlAsset: ImageUrl.pray_time,
                      name: "المؤذن",
                      onPressed: () {
                        Get.toNamed(Routes.pray_time);
                      },
                    ),
                    IconWidget(
                      urlAsset: ImageUrl.qibla,
                      name: "القبلة",
                      onPressed: () {
                        Get.toNamed(Routes.qibla);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
