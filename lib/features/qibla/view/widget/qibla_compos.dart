import 'dart:math';
import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/core/constant/manager_strings.dart';
import 'package:alraaqi_app/features/qibla/controller/qibla_controller.dart';
import 'package:alraaqi_app/features/qibla/view/widget/location_error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class QiblaCompass extends StatelessWidget {
  const QiblaCompass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QiblaController>(
      builder: (controller) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: controller.stream,
            builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CupertinoActivityIndicator();
              }
              if (snapshot.data!.enabled == true) {
                switch (snapshot.data!.status) {
                  case LocationPermission.always:
                  case LocationPermission.whileInUse:
                    return QiblahCompassWidget();
                  case LocationPermission.denied:
                    return LocationErrorWidget(
                      error: "Location service permission denied",
                      callback: controller.checkLocationStatus,
                    );
                  case LocationPermission.deniedForever:
                    return LocationErrorWidget(
                      error: "Location service Denied Forever !",
                      callback: controller.checkLocationStatus,
                    );
                  default:
                    return Container();
                }
              } else {
                return LocationErrorWidget(
                  error: ManagerStrings.qiblaError,
                  callback: controller.checkLocationStatus,
                );
              }
            },
          ),
        );
      },
    );
  }
}

class QiblahCompassWidget extends StatelessWidget {
  final _kaabaSvg = SvgPicture.asset('assets/svg/4.svg');
  QiblahCompassWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QiblaController>(builder: (controller) {
      return StreamBuilder(
        stream: FlutterQiblah.qiblahStream,
        builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Unable to get Qibla direction."));
          }
          final qiblahDirection = snapshot.data!;
          controller.animation = Tween(
                  begin: controller.begin,
                  end: (qiblahDirection.qiblah * (pi / 180) * -1))
              .animate(controller.animationController!);
          controller.begin = (qiblahDirection.qiblah * (pi / 180) * -1);
          controller.animationController!.forward(from: 0);
          return Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Compass angle:${snapshot.data!.direction.toStringAsFixed(2)}",
                style: TextStyle(
                    fontFamily: "Noor",
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Qibla angle:${controller.fixedQiblaAngle?.toStringAsFixed(1) ?? "..."}",
                style: TextStyle(
                    fontFamily: "Noor",
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              AnimatedBuilder(
                  animation: controller.animation!,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Transform.rotate(
                          angle: controller.animation!.value,
                          child: SvgPicture.asset('assets/svg/5.svg', // compass
                              color: ColorCode.mainColor),
                        ),
                        _kaabaSvg,
                        SvgPicture.asset('assets/svg/3.svg', //needle
                            color: ColorCode.mainColor),
                        
                      ],
                    );
                  }),
            ],
          );
        },
      );
    });
  }
}
