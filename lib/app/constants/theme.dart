import 'package:flutter/material.dart';

Color primaryColor = Color(0xff431AA1);
Color secondaryColor = Color(0xff9345F2);
Color thirdColor = Color(0xff2E0D8A);
Color lightPrimary = Color(0xffB9A2D8);
Color darkPrimary = Color(0xff260F68);
Color orangeColor = Color(0xffE6704A);
Color whiteColor = Color(0xffFAF8FC);


ThemeData appLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 4,
    backgroundColor: primaryColor
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: darkPrimary
    ),
    bodyText2: TextStyle(
      color: darkPrimary
    ),
  ),
  listTileTheme: ListTileThemeData(
    textColor: darkPrimary
  ),
  tabBarTheme: TabBarTheme(
    labelColor: darkPrimary,
    unselectedLabelColor: Colors.grey,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: darkPrimary
        )
      )
    )
  )
);

ThemeData appDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: lightPrimary,
  scaffoldBackgroundColor: darkPrimary,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: darkPrimary
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: whiteColor
    ),
    bodyText2: TextStyle(
      color: whiteColor
    ),
  ),
  listTileTheme: ListTileThemeData(
    textColor: whiteColor
  ),
  tabBarTheme: TabBarTheme(
    labelColor: whiteColor,
    unselectedLabelColor: Colors.grey,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: whiteColor
        )
      )
    )
  )
);