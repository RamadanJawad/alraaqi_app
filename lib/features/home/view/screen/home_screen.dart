import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/constant/manager_strings.dart';
import 'package:alraaqi_app/core/shared/shared_perf.dart';
import 'package:alraaqi_app/features/favorite/view/favorite_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:alraaqi_app/features/audio/view/widget/play_tool.dart';
import 'package:alraaqi_app/features/home/controller/home_controller.dart';
import 'package:alraaqi_app/features/home/view/widget/ayha_widget.dart';
import 'package:alraaqi_app/features/home/view/widget/custom_counter.dart';
import 'package:alraaqi_app/features/home/view/widget/hadees.dart';
import 'package:alraaqi_app/features/home/view/widget/header_widget.dart';
import 'package:alraaqi_app/features/pray_time/view/widget/praytime_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Directionality(
      textDirection: controller.appSettingsPrefs.getLocale() == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: ColorCode.mainColor),
                child: Center(
                  child: Text(
                    ManagerStrings.list,
                    style: TextStyle(
                        fontFamily: "Noor",
                        fontSize: 30.sp,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text(
                  ManagerStrings.changeLanguage,
                  style: TextStyle(
                      fontFamily: "Noor",
                      fontSize: 15.sp,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                onTap: () {
                  Get.back(); // لإغلاق الدرج
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(
                              'العربية',
                              style: TextStyle(
                                  fontFamily: "Noor",
                                  fontSize: 14.sp,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            onTap: () {
                              controller.changeLanguage(
                                  context: context, languageCode: "ar");
                              Get.back();
                            },
                          ),
                          ListTile(
                            title: Text(
                              'English',
                              style: TextStyle(
                                  fontFamily: "Noor",
                                  fontSize: 14.sp,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            onTap: () {
                              controller.changeLanguage(
                                  context: context, languageCode: "en");
                              Get.back();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text(
                  ManagerStrings.favorite,
                  style: TextStyle(
                      fontFamily: "Noor",
                      fontSize: 15.sp,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                onTap: () async {
                  Get.to(() => FavoriteScreen());
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  ManagerStrings.aboutUs,
                  style: TextStyle(
                      fontFamily: "Noor",
                      fontSize: 15.sp,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                onTap: () {
                  Get.back(); // لإغلاق الدرج
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(ManagerStrings.aboutUs),
                      content: Text(
                        "تم تنفيذ هذا التطبيق بواسطةفاعلة خير قطرية ..الهدف من هذا التطبيق هو الاجر من اللّٰه سبحانه وتعالى ولاستفادة اكبر شريحة من المجتمع العربيوالاسلامي بالعلاج بالقرآن الكريمارجوا الدعاء لي بالتوفيق والنجاحوالاجر لي ولوالدتي التي كانت الداعم الاكبر لي ولكل من شجعني ودعمني معنويا والعاملين على نجاحهذا التطبيق..في النهاية ( اللهم اعنا على ذكرك وشكرك وحسن عبادتك )",
                        style: TextStyle(
                            fontFamily: "Noor",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('إغلاق'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_email_rounded),
                title: Text(
                  ManagerStrings.contactUs,
                  style: TextStyle(
                      fontFamily: "Noor",
                      fontSize: 15.sp,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                onTap: () async {
                  Uri gmailUrl = Uri.parse(
                      'mailto:Al_raqi1@outlook.com?subject=الدعم الفني:&body=');
                  Get.back();
                  if (!await launchUrl(gmailUrl)) {
                    throw 'Could not launch $gmailUrl';
                  }
                },
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20.h),
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background_home.png"),
                fit: BoxFit.fill),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ListView(
                children: [
                  HeaderWidget(
                    itemData: controller.itemData,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  PrayTimeWidget(),
                  SizedBox(
                    height: 5.h,
                  ),
                  Obx(
                    () => CustomCounter(
                      counter: controller.counter.value.toString(),
                      onPressedAdd: () => controller.changeCounter(),
                      onPressedReply: () => controller.counter.value = 0,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  AyhaWidget(),
                  SizedBox(
                    height: 5.h,
                  ),
                  HadeesWidget(),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
              Builder(builder: (innerContext) {
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            Scaffold.of(innerContext).openEndDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                            size: 30,
                          )),
                    ),
                    GetBuilder<HomeController>(
                      builder: (controller) =>
                          controller.controllerAudio.isShow.value
                              ? const PlayTool()
                              : const SizedBox.shrink(),
                    )
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
