import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/constant/manager_strings.dart';
import 'package:alraaqi_app/core/functions/pray_time.dart';
import 'package:alraaqi_app/features/pray_time/controller/prayTime_controller.dart';
import 'package:alraaqi_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrayTimeWidget extends StatelessWidget {
  const PrayTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayTimeController>(
      init: PrayTimeController(),
      builder: (controller) {
        check(controller);
        return InkWell(
          onTap: () {
            Get.toNamed(Routes.pray_time);
          },
          child: Container(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          controller.currentPray,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: "Noor",
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          controller.prayTime,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: "Noor",
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 1)),
                          builder: (context, snapshot) {
                            return Text(
                              controller.dateTime
                                  .difference(DateTime.now())
                                  .toString()
                                  .split('.')[0],
                              style: TextStyle(
                                  fontSize: 26.sp,
                                  fontFamily: "Noor",
                                  color: ColorCode.mainColor),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          ManagerStrings.remaining,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: "Noor",
                              color: ColorCode.secondaryColor),
                        ),
                      ],
                    ),
                    Text(
                      controller.hijri!,
                      style: TextStyle(
                        fontFamily: "Noor",
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  controller.image,
                  width: 75.w,
                  height: 75.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
