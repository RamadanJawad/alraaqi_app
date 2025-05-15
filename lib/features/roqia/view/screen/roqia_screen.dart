import 'package:alraaqi_app/core/constant/manager_strings.dart';
import 'package:alraaqi_app/features/roqia/controller/roqia_controller.dart';
import 'package:alraaqi_app/features/roqia/view/screen/details_screen.dart';
import 'package:alraaqi_app/features/roqia/view/widget/play_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alraaqi_app/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RoqiaScreen extends StatelessWidget {
  const RoqiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RoqiaController());
    return Directionality(
        textDirection: controller.appSettingsPrefs.getLocale() == "ar"
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
          backgroundColor: ColorCode.backgroundColor,
          appBar: AppBar(
            backgroundColor: ColorCode.mainColor,
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.favorite))],
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              ManagerStrings.ruqyahShariah,
              style: TextStyle(
                  fontFamily: "Noor",
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: GetBuilder<RoqiaController>(builder: (controller) {
            return Stack(
              children: [
                GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: controller.mainItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.mainItems[index];
                      return InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(
                                title: item['title'],
                                items: List<Map<String, String>>.from(
                                    item['items']),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
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
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.asset(
                                  "assets/images/roqia.jpeg",
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  height: 100.h,
                                ),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(
                                  item['title'],
                                  style: TextStyle(
                                      fontFamily: "Noor",
                                      fontSize: 15.sp,
                                      overflow: TextOverflow.clip,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                trailing: Container(
                                  width: 35.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Icon(
                                    CupertinoIcons.arrow_left_square,
                                    color: ColorCode.mainColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                Obx(() {
                  if (controller.isShow.value) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: PlayToolRoqia(),
                    );
                  } else {
                    return SizedBox
                        .shrink(); // لا شيء إذا لم يكن الشريط مفعّلًا
                  }
                }),
              ],
            );
          }),
        ));
  }
}
