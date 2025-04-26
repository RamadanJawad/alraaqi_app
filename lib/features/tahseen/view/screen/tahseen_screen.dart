import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/features/tahseen/view/widget/body_tahseen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TahseenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: ColorCode.backgroundColor,
          appBar: AppBar(
            backgroundColor: ColorCode.mainColor,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "التحصينات",
              style: TextStyle(
                  fontFamily: "Noor",
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: const BodyTahseen()),
    );
  }
}
