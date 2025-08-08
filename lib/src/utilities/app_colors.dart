import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xff0816FD);
  static const Color secondaryColor = Color(0xFF01050e);
  static const Color lightColor = Color(0xFFF1E2D5);

  static const Color iconColor = Colors.black;
  static const Color unselectedColor = Color(0xff9CA3AF);

  static const Color borderColor = Color(0xffE5E7EB);

  static const Color authButtonColor = Color(0xFFF2F3F6);

  static const Color backgroundColor = Color(0xffF0F0F0);
  static const Color textColor = Color(0xFF000000);
  static const Color textLinkColor = Color(0xff116DA1);

  static const Color shadowColor = Color(0xffDFDFDF);
  static const Color disabledColor = Color(0xFFA0A0A0);

  static const Color absentColor = Color(0xffE1101B);
  static const Color presentColor = Color(0xff0AB71B);
  static const Color redTextColor = Color(0xffFF0000);
  static const Color greenTextColor = Color(0xff69C52B);

  static const itemCheckColor = Color(0xff0AB71B);
  static const Color errorColor = Color(0xFFE31D1A);
  static const Color successColor = Color(0xFF07DF00);
  static const Color warningColor = Color(0xFFEEA71D);

  static const Color goldenText = Color(0xffb58729);

  static const Color drawerColor = Color(0xFFf0f2f5);

  // Chart color
  static const Color colorAl = Color(0xFF1F77B4); // Deep Blue
  static const Color colorSl = Color(0xFFFF7F0E); // Vivid Orange
  static const Color colorLop = Color(0xFFD62728); // Green
  static const Color colorCompoff = Color(0xFF2CA02C); // Strong Red

  static const LinearGradient menuGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFEDEDED),
      Color.fromARGB(0, 224, 224, 224), // hsla(0, 0%, 88%, 0) equivalent
    ],
  );

  static const MaterialColor primarySwatch = MaterialColor(0xFFF8F8F8, <int, Color>{
    50: Color(0xFFFDFDFD),
    100: Color(0xFFFBFBFB),
    200: Color(0xFFF8F8F8),
    300: Color(0xFFF5F5F5),
    400: Color(0xFFF2F2F2),
    500: Color(0xFFF0F0F0),
    600: Color(0xFFEEEEEE),
    700: Color(0xFFECECEC),
    800: Color(0xFFEAEAEA),
    900: Color(0xFFE8E8E8),
  });
}
