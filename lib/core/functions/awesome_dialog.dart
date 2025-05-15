import 'package:alraaqi_app/core/constant/manager_strings.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showAwesomeDialog(
    {BuildContext? context,
    String? description,
    DialogType? dialogType,
    void Function()? btnOkOnPress,
    void Function()? btnCancelOnPress}) {
  AwesomeDialog(
          context: context!,
          dialogType: dialogType!,
          animType: AnimType.rightSlide,
          title: ManagerStrings.info,
          desc: description,
          descTextStyle: TextStyle(fontFamily: "Noor", fontSize: 16.sp),
          titleTextStyle: TextStyle(fontFamily: "Noor", fontSize: 17.sp),
          buttonsTextStyle: TextStyle(fontFamily: "Noor", fontSize: 16.sp),
          btnOkOnPress: btnOkOnPress,
          btnCancelOnPress: btnCancelOnPress)
      .show();
}
