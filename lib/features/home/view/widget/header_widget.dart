import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/constant/manager_strings.dart';
import 'package:alraaqi_app/features/home/view/widget/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.itemData});
  final List itemData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 180.h, left: 10, right: 10, bottom: 3),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20).r,
            topRight: const Radius.circular(20).r,
            bottomLeft: const Radius.circular(5).r,
            bottomRight: const Radius.circular(5).r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              ManagerStrings.shortcuts,
              style: TextStyle(
                  fontFamily: "Noor",
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: ColorCode.secondaryColor),
            ),
            const Divider(
              endIndent: 6,
              indent: 6,
              thickness: 1,
            ),
            SizedBox(
              height: 160.h,
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: itemData.length,
                  itemBuilder: (context, index) {
                    return IconWidget(
                      urlAsset: itemData[index]['imageUrl'],
                      name: itemData[index]['name'],
                      onPressed: () {
                        Get.toNamed(
                          itemData[index]['onPressed'],
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
