import 'package:alraaqi_app/features/pray_time/controller/prayTime_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomPrayTime extends StatelessWidget {
  final void Function()? onTap;
  final String imagePath;
  final String prayTimeName;
  final String prayTime;
  final bool isTapped;
  const CustomPrayTime({
    Key? key,
    this.onTap,
    required this.imagePath,
    required this.prayTimeName,
    required this.prayTime,
    required this.isTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayTimeController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10).r,
              border: Border.all(color: Colors.grey, width: 1.w),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      imagePath,
                      width: 30.w,
                      height: 30.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      prayTimeName,
                      style: TextStyle(fontFamily: "Noor", fontSize: 20.sp),
                    ),
                    const Spacer(),
                    Text(
                      prayTime,
                      style: TextStyle(fontFamily: "Noor", fontSize: 20.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
