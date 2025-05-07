import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/constant/image_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCounter extends StatelessWidget {
  const CustomCounter(
      {super.key,
      required this.counter,
      this.onPressedReply,
      this.onPressedAdd});

  final String counter;
  final void Function()? onPressedReply;
  final void Function()? onPressedAdd;

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                ImageUrl.icon,
                width: 23.w,
                height: 23.w,
              ),
              Text("عداد الصلاة على النبي",
                  style: TextStyle(
                      fontFamily: "Noor",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold)),
              Spacer(),
              IconButton(
                onPressed: onPressedReply,
                icon: Icon(
                  Icons.replay,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: ColorCode.mainColor),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "اللهم صل وسلم وبارك على نبينا محمد ﷺ",
                  style: TextStyle(
                      fontFamily: "Noor", fontSize: 20.sp, color: Colors.white),
                ),
                SizedBox(
                  width: 70.w,
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: onPressedAdd,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: Text(
                      counter,
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 18.sp,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
