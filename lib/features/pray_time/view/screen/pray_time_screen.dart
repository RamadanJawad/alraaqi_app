import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/functions/location.dart';
import 'package:alraaqi_app/core/functions/snackbar.dart';
import 'package:alraaqi_app/features/pray_time/controller/prayTime_controller.dart';
import 'package:alraaqi_app/features/pray_time/view/widget/body_prayTime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrayTimeScreen extends StatelessWidget {
  const PrayTimeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrayTimeController());
    checkLocation(context, controller);
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
                if (controller.appSettings == null &&
                    controller.appSettings == null) {
                  getLatAndLong(controller);
                } else {
                  showSnackBar(
                      context, "تم تحديث أوقات الصلاة بنجاح", Colors.grey);
                }
              },
              icon: const Icon(Icons.my_location_sharp),
            ),
            GetBuilder<PrayTimeController>(builder: (controller) {
              return IconButton(
                onPressed: () {
                  controller.prayTimeNotification();
                },
                icon: Icon(
                  controller.appSettings.status1
                      ? Icons.notifications_active
                      : Icons.notifications_off,
                  color: controller.appSettings.status1
                      ? Colors.green
                      : Colors.grey,
                ),
              );
            })
          ],
          backgroundColor: ColorCode.mainColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "أوقات الصلاة",
            style: TextStyle(
                fontFamily: "Noor",
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: const BodyPrayTime(),
      ),
    );
  }
}
