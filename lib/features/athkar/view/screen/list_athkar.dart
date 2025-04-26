import 'package:alraaqi_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ListDataAthkar extends StatelessWidget {
  final String name;
  final List data;
  const ListDataAthkar({
    super.key,
    required this.name,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorCode.mainColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            name,
            style: TextStyle(
                fontFamily: "Cairo", fontSize: 20.sp, color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            "assets/images/vector.png",
                            width: 40.w,
                            height: 40.h,
                            color: ColorCode.mainColor,
                          ),
                          Text(
                            "${data[index]['id']}",
                            style:
                                TextStyle(fontSize: 17.sp, fontFamily: "Cairo"),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 200.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            color: ColorCode.mainColor,
                            borderRadius: BorderRadius.circular(15).r),
                        child: Text("عدد المرات :${data[index]['counter']}",
                            style: TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 15.sp,
                                color: Colors.white)),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text:
                                    "$name \n${data[index]['text']}${data[index]['counter']} مرات "));
                            Get.showSnackbar(const GetSnackBar(
                              backgroundColor: ColorCode.mainColor,
                              messageText: Text(
                                "تم نسخ النص بنجاح ",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Cairo",
                                    fontSize: 15),
                              ),
                              duration: Duration(seconds: 2),
                            ));
                          },
                          icon: const Icon(Icons.copy)),
                      IconButton(
                          onPressed: () async {
                            await Share.share(
                                "$name\n${data[index]['text']}${data[index]['counter']} مرات ");
                          },
                          icon: const Icon(Icons.share))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "${data[index]['text']}",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontFamily: "Cairo", fontSize: 17.sp),
                  ),
                  const Divider(
                    color: Colors.black38,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
