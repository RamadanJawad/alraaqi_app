// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alraaqi_app/core/data/data.dart';
import 'package:alraaqi_app/features/tahseen/controller/tahseen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alraaqi_app/core/constant/color.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class SavedTahseenScreen extends StatelessWidget {
  final List<String> azkarList;
  final Set<int> favoriteIndices;
  SavedTahseenScreen({
    super.key,
    required this.azkarList,
    required this.favoriteIndices,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteAzkar = favoriteIndices.map((i) => azkarList[i]).toList();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: ColorCode.backgroundColor,
          appBar: AppBar(
            backgroundColor: ColorCode.mainColor,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "التحصينات المحفوظة",
              style: TextStyle(
                  fontFamily: "Noor",
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: favoriteAzkar.isEmpty
              ? Center(
                  child: Text('لا توجد أذكار مفضلة بعد.',
                      textDirection: TextDirection.rtl))
              : GetBuilder<TahseenController>(
                  init: TahseenController(),
                  builder: (controller) {
                    return ListView.builder(
                        itemCount: favoriteAzkar.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
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
                                              fontSize: 18.sp,
                                              fontFamily: "Noor"),
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
                                              text:
                                                  Data().ad3yaTahseen[index]));
                                          Get.showSnackbar(const GetSnackBar(
                                            backgroundColor:
                                                ColorCode.mainColor,
                                            messageText: Text(
                                              "تم نسخ النص بنجاح ",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Noor",
                                                  fontSize: 15),
                                            ),
                                            duration: Duration(seconds: 2),
                                          ));
                                        },
                                        icon: const Icon(Icons.copy)),
                                    IconButton(
                                        onPressed: () async {
                                          await Share.share(
                                              favoriteAzkar[index]);
                                        },
                                        icon: const Icon(Icons.share)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  favoriteAzkar[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Noor", fontSize: 19.sp),
                                ),
                                const Divider(
                                  color: Colors.black38,
                                )
                              ],
                            ),
                          );
                        });
                  })),
    );
  }
}
