import 'package:alraaqi_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderNameWidget extends StatelessWidget {
  const HeaderNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      WidgetSpan(
          child: Image.asset(
        "assets/images/arabic.png",
        width: 23.w,
        height: 23.h,
      )),
      TextSpan(
        text: "الاختصارات",
        style: TextStyle(
          fontSize: 20.sp,
          color: ColorCode.secondaryColor,
          fontFamily: "Noor",
        ),
      ),
    ]));
  }
}
