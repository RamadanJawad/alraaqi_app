import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/data/data.dart';
import 'package:alraaqi_app/features/tahseen/controller/tahseen_controller.dart';
import 'package:alraaqi_app/features/tahseen/view/screen/saved_tashseen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class TahseenScreen extends StatelessWidget {
  const TahseenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TahseenController());
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
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SavedTahseenScreen(
                              azkarList: Data().ad3yaTahseen,
                              favoriteIndices: controller.favoriteIndices)),
                    );
                  },
                  icon: const Icon(Icons.bookmark))
            ],
          ),
          body: GetBuilder<TahseenController>(builder: (controller) {
            return ListView.builder(
              itemCount: Data().ad3yaTahseen.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                                style: TextStyle(
                                    fontSize: 18.sp, fontFamily: "Noor"),
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
                                Get.showSnackbar(GetSnackBar(
                                  backgroundColor: ColorCode.mainColor,
                                  messageText: Text(
                                    "تم نسخ النص بنجاح ",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Noor",
                                        fontSize: 17.sp),
                                  ),
                                  duration: Duration(seconds: 2),
                                ));
                              },
                              icon: const Icon(Icons.copy)),
                          IconButton(
                              onPressed: () async {
                                await Share.share(Data().ad3yaTahseen[index]);
                              },
                              icon: const Icon(Icons.share)),
                          IconButton(
                              onPressed: () async {
                                controller.toggleFavorite(index);
                              },
                              icon: Icon(
                                Icons.bookmark_add_rounded,
                                color:
                                    controller.favoriteIndices.contains(index)
                                        ? ColorCode.mainColor
                                        : null,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        Data().ad3yaTahseen[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: "Noor", fontSize: 19.sp),
                      ),
                      const Divider(
                        color: Colors.black38,
                      )
                    ],
                  ),
                );
              },
            );
          })),
    );
  }
}
