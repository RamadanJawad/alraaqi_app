import 'package:alraaqi_app/core/constant/image_url.dart';
import 'package:alraaqi_app/core/constant/manager_strings.dart';
import 'package:alraaqi_app/features/pray_time/controller/prayTime_controller.dart';
import 'package:alraaqi_app/features/pray_time/view/widget/custom_prayTime.dart';
import 'package:alraaqi_app/features/pray_time/view/widget/praytime_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BodyPrayTime extends StatelessWidget {
  const BodyPrayTime({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayTimeController>(
      builder: (controller) {
        return Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            const PrayTimeWidget(),
            SizedBox(
              height: 10.h,
            ),
            CustomPrayTime(
              isTapped: controller.isTapped,
              onTap: () {
                controller.isTapController();
              },
              imagePath: ImageUrl.fajr,
              prayTime: DateFormat.jm().format(controller.prayerTimes.fajr),
              prayTimeName: ManagerStrings.fajrPrayer,
            ),
            CustomPrayTime(
              isTapped: controller.isTapped1,
              onTap: () {
                controller.isTapController1();
              },
              imagePath: ImageUrl.sunrise,
              prayTime: DateFormat.jm().format(controller.prayerTimes.sunrise),
              prayTimeName: ManagerStrings.shurooqPrayer,
            ),
            CustomPrayTime(
              isTapped: controller.isTapped2,
              onTap: () {
                controller.isTapController2();
              },
              imagePath: ImageUrl.dhuhr,
              prayTime: DateFormat.jm().format(controller.prayerTimes.dhuhr),
              prayTimeName: ManagerStrings.dhuhrPrayer,
            ),
            CustomPrayTime(
              isTapped: controller.isTapped3,
              onTap: () {
                controller.isTapController3();
              },
              imagePath: ImageUrl.asr,
              prayTime: DateFormat.jm().format(controller.prayerTimes.asr),
              prayTimeName: ManagerStrings.asrPrayer,
            ),
            CustomPrayTime(
              isTapped: controller.isTapped4,
              onTap: () {
                controller.isTapController4();
              },
              imagePath: ImageUrl.maghrib,
              prayTime: DateFormat.jm().format(controller.prayerTimes.maghrib),
              prayTimeName: ManagerStrings.maghribPrayer,
            ),
            CustomPrayTime(
              isTapped: controller.isTapped5,
              onTap: () {
                controller.isTapController5();
              },
              imagePath: ImageUrl.isha,
              prayTime: DateFormat.jm().format(controller.prayerTimes.isha),
              prayTimeName: ManagerStrings.ishaPrayer,
            ),
          ],
        );
      },
    );
  }
}
