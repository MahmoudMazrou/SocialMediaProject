
import 'package:asochialmedia/modules/log_in_page/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
//عبارة عن شاشة تظهر قبل فتح التطبيق
class SpllashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SplashScreen(
          backgroundColor: Colors.white38,//لون الخلفية
          image: Image.asset('assets/images/splashImg.jpg'), //الصورة
          photoSize: 180, //حجم الصورة
          seconds: 3, //مددة الظهور
          navigateAfterSeconds: LogInPage(),//المكان الي بكون ب الرن بتطبيقنا بنقلو هين
          title: Text("Splash Screen!!!!!!"),
          loaderColor: Colors.yellow,
          loadingText: Text("Getting Page Ready!"),

        ),
      );

  }
}


