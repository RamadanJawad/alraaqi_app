import 'package:alraaqi_app/core/data/data.dart';
import 'package:alraaqi_app/features/audio/controller/audio_controller.dart';
import 'package:alraaqi_app/features/audio/view/widget/play_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecitersWidget extends StatelessWidget {
  const RecitersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(
      builder: (controller) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView.builder(
              itemCount: Data().reciters.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.changeIndex(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 4.h),
                        width: double.infinity,
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200]!,
                                  offset: const Offset(0, 10),
                                  blurRadius: 10,
                                  spreadRadius: 1),
                            ],
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 6.w,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.asset(
                                Data().reciters[index]['image'],
                                width: 50.w,
                                fit: BoxFit.cover,
                                height: 50.h,
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              Data().reciters[index]['name2'],
                              style: TextStyle(
                                  fontFamily: "Noor",
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            controller.isShow.value ? const PlayTool() : const SizedBox.shrink()
          ],
        );
      },
    );
  }
}
