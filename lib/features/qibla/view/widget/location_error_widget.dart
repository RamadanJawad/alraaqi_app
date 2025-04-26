import 'package:alraaqi_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationErrorWidget extends StatelessWidget {
  final String? error;
  final Function? callback;

  const LocationErrorWidget({Key? key, this.error, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "assets/images/location.png",
            width: double.infinity,
            height: 200.h,
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            error!,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorCode.secondaryColor,
                fontSize: 19.sp,
                fontFamily: "Noor"),
          ),
          SizedBox(
            height: 30.h,
          ),
          SizedBox(
            width: 150.w,
            height: 40.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  backgroundColor: ColorCode.mainColor),
              onPressed: () {
                if (callback != null) callback!();
              },
              child: Text(
                "حاول مجددا",
                style: TextStyle(fontFamily: "Noor", color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
