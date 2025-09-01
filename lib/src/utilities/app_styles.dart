import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  //  Text Styles
  static TextStyle getExtraLightTextStyle({required double fontSize, Color? color, bool isCurrency = false}) {
    return TextStyle(fontSize: fontSize, fontFamily: "Vazirmatn", color: color, fontWeight: FontWeight.w200);
  }

  static TextStyle getLightTextStyle({required double fontSize, Color? color, bool isCurrency = false}) {
    return TextStyle(fontSize: fontSize, fontFamily: "Vazirmatn", color: color, fontWeight: FontWeight.w300);
  }

  static TextStyle getRegularTextStyle({required double fontSize, Color? color, bool isCurrency = false}) {
    return TextStyle(fontSize: fontSize, fontFamily: "Vazirmatn", color: color, fontWeight: FontWeight.w400, height: 1.7);
  }

  static TextStyle getBoldTextStyle({required double fontSize, Color? color, bool isCurrency = false}) {
    return TextStyle(fontSize: fontSize, fontFamily: "Vazirmatn", fontWeight: FontWeight.w700, color: color);
  }

  static TextStyle getSemiBoldTextStyle({required double fontSize, Color? color, bool isCurrency = false}) {
    return TextStyle(fontSize: fontSize, fontFamily: "Vazirmatn", fontWeight: FontWeight.w600, color: color);
  }

  static TextStyle getMediumTextStyle({required double fontSize, Color? color, bool isCurrency = false}) {
    return TextStyle(fontSize: fontSize, fontFamily: "Vazirmatn", fontWeight: FontWeight.w500, color: color);
  }

  // Button styles
  static ButtonStyle filledButton({Color? backgroundColor, Color? foregroundColor, EdgeInsets? padding}) {
    return TextButton.styleFrom(
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      foregroundColor: foregroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      padding: padding ?? EdgeInsets.all(8),
    );
  }

  static ButtonStyle outlineButton({Color? backgroundColor, Color? foregroundColor, EdgeInsets? padding}) {
    return TextButton.styleFrom(
      // backgroundColor: backgroundColor ?? AppColors.primaryColor,
      foregroundColor: foregroundColor ?? AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: foregroundColor ?? AppColors.primaryColor),
      ),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    );
  }
}
