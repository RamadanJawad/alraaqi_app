import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/features/home/controller/home_controller.dart';
import 'package:alraaqi_app/features/home/view/widget/ayha_widget.dart';
import 'package:alraaqi_app/features/home/view/widget/custom_counter.dart';
import 'package:alraaqi_app/features/home/view/widget/hadees.dart';
import 'package:alraaqi_app/features/home/view/widget/header_widget.dart';
import 'package:alraaqi_app/features/pray_time/view/widget/praytime_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorCode.backgroundColor,
        body: SafeArea(
          child: ListView(
            children: [
              HeaderWidget(),
              SizedBox(
                height: 5.h,
              ),
              PrayTimeWidget(),
              SizedBox(
                height: 5.h,
              ),
              Obx(
                () => CustomCounter(
                  counter: controller.counter.value.toString(),
                  onPressedAdd: () => controller.changeCounter(),
                  onPressedReply: () => controller.counter.value = 0,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              AyhaWidget(),
              SizedBox(
                height: 5.h,
              ),
              HadeesWidget(),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
