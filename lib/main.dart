import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:requran/app/constants/theme.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appLight,
      darkTheme: appDark,
      title: "Application",
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
    ),
  );
}
