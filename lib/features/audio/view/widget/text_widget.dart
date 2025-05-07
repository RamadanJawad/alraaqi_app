import 'package:alraaqi_app/features/audio/controller/audio_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextWidget extends StatelessWidget {
  final String text1;
  final void Function()? onTap;
  final bool visible;
  const TextWidget({
    Key? key,
    required this.text1,
    this.onTap,
    required this.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1,
              style: TextStyle(
                  fontFamily: "Noor",
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
            Visibility(
              visible: visible,
              child: InkWell(
                onTap: onTap,
                child: const Icon(CupertinoIcons.search),
              ),
            ),
          ],
        ),
      );
    });
  }
}
