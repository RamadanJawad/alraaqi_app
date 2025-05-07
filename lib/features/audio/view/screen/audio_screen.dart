import 'package:alraaqi_app/core/constant/color.dart';
import 'package:alraaqi_app/features/audio/controller/audio_controller.dart';
import 'package:alraaqi_app/features/audio/view/screen/favorite_audio.dart';
import 'package:alraaqi_app/features/audio/view/widget/reciters_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AudioController());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => FavoriteAudio());
                },
                icon: Icon(Icons.favorite))
          ],
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("القرآن استماع",
              style: TextStyle(
                  fontFamily: "Noor",
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          backgroundColor: ColorCode.mainColor,
          elevation: 0,
        ),
        body: const RecitersWidget(),
      ),
    );
  }
}
