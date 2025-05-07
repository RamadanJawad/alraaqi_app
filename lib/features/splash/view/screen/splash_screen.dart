import 'package:alraaqi_app/features/splash/view/widget/body_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: BodySplash(),
    );
  }
}
