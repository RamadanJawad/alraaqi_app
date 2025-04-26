import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/features/quran/controller/tabs_controller.dart';
import 'package:alraaqi_app/features/quran/view/widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Get.put<TabsController>(TabsController());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<TabsController>(
        builder: (controller) {
          return Scaffold(
            drawer: Drawer(
              child: DrawerWidget(),
            ),
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text("القرآن الكريم",
                  style: TextStyle(
                      fontFamily: "Noor",
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              backgroundColor: ColorCode.mainColor,
              elevation: 0,
            ),
            body: SafeArea(
              child: SfPdfViewer.asset(
                  controller: controller.pdfViewerController,
                  'assets/pdf/quran.pdf'),
            ),
          );
        },
      ),
    );
  }
}
