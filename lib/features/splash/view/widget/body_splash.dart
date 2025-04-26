import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/constant/image_url.dart';
import 'package:alraaqi_app/features/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BodySplash extends StatelessWidget {
  const BodySplash({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Column(
          children: [
            const Spacer(),
            FadeTransition(
              opacity: controller.curve,
              child: Column(
                children: [
                  Text(
                    "الراقــــي",
                    style: TextStyle(
                        fontFamily: "Noor",
                        fontWeight: FontWeight.bold,
                        color: ColorCode.mainColor,
                        fontSize: 30.sp),
                  )
                ],
              ),
            ),
            const Spacer(),
            Image.asset(
              ImageUrl.mosque,
              color: ColorCode.mainColor,
            ),
          ],
        );
      },
    );
  }
}
