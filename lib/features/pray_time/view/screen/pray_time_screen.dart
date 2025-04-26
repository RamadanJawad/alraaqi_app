import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/functions/location.dart';
import 'package:alraaqi_app/core/functions/snackbar.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
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
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorCode.backgroundColor,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                if (SharedPrefController().latitude == null &&
                    SharedPrefController().longitude == null) {
                  getLatAndLong(controller);
                } else {
                  showSnackBar(
                      context, "تم تحديث أوقات الصلاة بنجاح", Colors.grey);
                }
              },
              icon: const Icon(Icons.my_location_sharp),
            ),
            IconButton(
              onPressed: () {
                controller.prayTimeNotification();
              },
              icon: const Icon(Icons.notifications,),
            )
          ],
          backgroundColor: ColorCode.mainColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "أوقات الصلاة",
            style: TextStyle(
                fontFamily: "Noor",
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: const BodyPrayTime(),
      ),
    );
  }
}
