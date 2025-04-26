import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/features/athkar/controller/athkar_controller.dart';
import 'package:alraaqi_app/features/athkar/view/widget/body_athkart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AthkarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(AthkarController());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: ColorCode.backgroundColor,
          appBar: AppBar(
            backgroundColor: ColorCode.mainColor,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "الاذكار",
              style: TextStyle(
                  fontFamily: "Noor",
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: BodyAthkar()),
    );
  }
}
