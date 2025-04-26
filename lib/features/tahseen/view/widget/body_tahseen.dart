import 'package:alraaqi_app/core/data/data.dart';
import 'package:flutter/material.dart';
import 'package:alraaqi_app/core/constant/color.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class BodyTahseen extends StatelessWidget {
  const BodyTahseen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: ListView.builder(
          itemCount: Data().ad3yaTahseen.length,
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
                            "${index + 1}",
                            style:
                                TextStyle(fontSize: 17.sp, fontFamily: "Cairo"),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: Data().ad3yaTahseen[index]));
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
                            await Share.share(Data().ad3yaTahseen[index]);
                          },
                          icon: const Icon(Icons.share))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    Data().ad3yaTahseen[index],
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
