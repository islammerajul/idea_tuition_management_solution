import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class


  static const Map<int, Color> primary = <int, Color>{
    50: const Color(0xFF53BFB4),
    100: const Color(0xFF53BFB4),
    200: const Color(0xFF53BFB4),
    300: const Color(0xFF53BFB4),
    400: const Color(0xFF53BFB4),
    500: const Color(0xFF53BFB4),
    600: const Color(0xFF53BFB4),
    700: const Color(0xFF53BFB4),
    800: const Color(0xFF53BFB4),
    900: const Color(0xFF53BFB4)
  };
}

class CustomColors{

  static const BrandColor =  Color(0xFF17B9C5);
  static const titleBlack =  Color(0xFF2B2B2B);
  static const icontitleBlack =  Color(0xFF4B4B4B);
  static const White =  Color(0xFFFFFFFF);
  static const PrimaryColor =  Color(0xFF0B92A9);
  static const BoxColor =  Color(0xFF0D8FAC);
  static const AnotherBoxColor =  Color(0xFFF9F9F9);
  static const SmallTextColor =  Color(0xFF7E7E7E);
  static const singleDividerColor =  Color(0xFFEFEFEF);
  static const ButtonTextColor =  Color(0xFFA7A7A7);
  static const unselectTextButtonColor =  Color(0xFFA7A7A7);
  static const headerValueColor =  Color(0xFFA9A9A9);  // use in all hint textes
  static const BrightCyan =  Color(0xFF00A79D);
  static const typeofGreen =  Color(0xFF0BC974);
  static const anothertypeofGreen =  Color(0xFF0ED290);
  static const LightGreen =  Color(0xFF0BC974);
  static const Red =  Color(0xFFC2313C);
  static const typeofRed =  Color(0xFFF44336);
  static const anothertypeofRed =  Color(0xFFDB3744);
  static const typeofYellow =  Color(0xFFFFC107);
  static const DarkGrey =  Color(0xFF565656);
  static const TimeBox =  Color(0xFFEDFCFF); //use in 'Book Appointment second screen'
  static const Peice =  Color(0xFFDBD0D0); //use in 'Book Appointment second screen'

  static MaterialColor generateMaterialColorFromColor(Color color) {
    return MaterialColor(color.value, {
      50: Color.fromRGBO(color.red, color.green, color.blue, 0.1),
      100: Color.fromRGBO(color.red, color.green, color.blue, 0.2),
      200: Color.fromRGBO(color.red, color.green, color.blue, 0.3),
      300: Color.fromRGBO(color.red, color.green, color.blue, 0.4),
      400: Color.fromRGBO(color.red, color.green, color.blue, 0.5),
      500: Color.fromRGBO(color.red, color.green, color.blue, 0.6),
      600: Color.fromRGBO(color.red, color.green, color.blue, 0.7),
      700: Color.fromRGBO(color.red, color.green, color.blue, 0.8),
      800: Color.fromRGBO(color.red, color.green, color.blue, 0.9),
      900: Color.fromRGBO(color.red, color.green, color.blue, 1.0),
    });
  }

  static const primaryGradient= LinearGradient(
      colors: [
        CustomColors.PrimaryColor,
        const Color(0xFF00CCFF),
      ],
      begin: const FractionalOffset(0.0, 1.0),
      end: const FractionalOffset(1.0, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);
}