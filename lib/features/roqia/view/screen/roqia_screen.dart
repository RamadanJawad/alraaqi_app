import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/features/roqia/controller/roqia_controller.dart';
import 'package:alraaqi_app/features/roqia/view/widget/body_roqia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RoqiaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(RoqiaController());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: ColorCode.backgroundColor,
          appBar: AppBar(
            backgroundColor: ColorCode.mainColor,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "الرقية الشرعية",
              style: TextStyle(
                  fontFamily: "Noor",
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: const BodyRoqia()),
    );
  }
}
