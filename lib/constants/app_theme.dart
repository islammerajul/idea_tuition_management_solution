
import 'package:flutter/material.dart';
import 'colors.dart';
import 'font_family.dart';

final ThemeData themeData = ThemeData(
    fontFamily: FontFamily.roboto,
    brightness: Brightness.light,
    tabBarTheme: const TabBarTheme(
      labelColor: CustomColors.PrimaryColor,
      labelStyle: TextStyle(color: CustomColors.PrimaryColor),
        indicator: UnderlineTabIndicator( // color for indicator (underline)
      borderSide: BorderSide(color: CustomColors.PrimaryColor)),
    ),
    primaryColor: CustomColors.PrimaryColor,
    appBarTheme: AppBarTheme(
      color: CustomColors.PrimaryColor
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: MaterialColor(AppColors.primary[900]!.value, AppColors.primary)).copyWith(secondary: AppColors.primary[500])
);

final ThemeData themeDataDark = ThemeData(
  fontFamily: FontFamily.roboto,
  brightness: Brightness.dark,
  primaryColor:  CustomColors.PrimaryColor,
  //primaryColorBrightness: Brightness.dark,
);