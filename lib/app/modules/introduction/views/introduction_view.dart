import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:requran/app/constants/theme.dart';

import 'package:get/get.dart';
import 'package:requran/app/routes/app_pages.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Re - Qur'an",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "''Sebaik-baik kamu adalah orang yang mempelajari Alquran dan mengajarkannya.''\n ''(HR. Bukhari)''",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: lightPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 14
                ),
              ),
            ),
            SizedBox(height: 60),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 300,
                height: 300,
                child: Lottie.asset("assets/lottie/splash-quran.json")
                ),
            ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Get.offAllNamed(Routes.HOME), 
                child: Text(
                  "Ayo Mulai Membaca",
                  style: TextStyle(
                    color: Get.isDarkMode ? darkPrimary : whiteColor,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Get.isDarkMode ? whiteColor : primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15)
                ),
              )
          ],
        ),
      ),
    );
  }
}
