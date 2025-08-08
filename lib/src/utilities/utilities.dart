import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_styles.dart';

export 'app_colors.dart';
export 'app_icons.dart';
export 'app_images.dart';
export 'app_strings.dart';
export 'app_styles.dart';
export 'constants.dart';

String? validateEmail(String? value) {
  RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+\-\/=?^_`{|}~]+@[a-zA-Z0-9\-.]+\.[a-zA-Z]+");
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return "Enter a valid email";
  } else {
    return null;
  }
}

String? defaultValidator(String? value) => value != null && value.isNotEmpty ? null : "Required";

String? defaultNumberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Required";
  }
  if (double.tryParse(value) == null) {
    return "Check";
  }
  return null;
}

showSnackBar(
  BuildContext context, {
  required String message,
  required Color backgroundColor,
  Color? textColor,
  Duration? duration,
  SnackBarBehavior? behavior,
  SnackBarAction? action,
  List<String> errors = const [],
}) {
  // return ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     behavior: behavior,
  //     duration: duration ?? const Duration(milliseconds: 3000),
  //     content: Text(message, style: AppStyles.getRegularTextStyle(fontSize: 14, color: textColor ?? Colors.white)),
  //     backgroundColor: backgroundColor,
  //     dismissDirection: DismissDirection.startToEnd,
  //     action: action,
  //   ),
  // );

  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text("Notice", style: AppStyles.getMediumTextStyle(fontSize: 16)),
          content: Text(
            '$message${errors.isNotEmpty ? "\n${errors.join('\n')}" : ''}',
            style: AppStyles.getRegularTextStyle(fontSize: 14, color: textColor ?? Colors.black),
          ),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("OK")), if (action != null) action],
        ),
  );
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

Future deleteImageFromCache(String url) async {
  await CachedNetworkImage.evictFromCache(url);
}

// Future<File?> pickImage() async {
//   final imagePicker = ImagePicker();
//   var image = await imagePicker.pickImage(source: ImageSource.gallery);
//   if (image != null) {
//     return File(image.path);
//   }
//   return null;
// }

Future<DateTime?> pickDate(context, {DateTime? firstDate, DateTime? lastDate}) async {
  DateTime date = DateTime.now();
  if (Platform.isIOS) {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Column(
          children: [
            SizedBox(
              height: 300,
              child: CupertinoDatePicker(
                onDateTimeChanged: (value) => date = value,
                initialDateTime: firstDate,
                dateOrder: DatePickerDateOrder.dmy,
                mode: CupertinoDatePickerMode.date,
              ),
            ),
            CupertinoButton(child: const Text('OK'), onPressed: () => context.pop()),
          ],
        );
      },
    );
    return date;
  }
  return await showDatePicker(context: context, firstDate: firstDate ?? DateTime.now(), lastDate: DateTime(2100));
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295; //conversion factor from radians to decimal degrees, exactly math.pi/180
  var c = cos;
  var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  var radiusOfEarth = 6371;
  return radiusOfEarth * 1000 * 2 * asin(sqrt(a));
}

getProfilePic(String? imageUrl) {
  if (imageUrl == null) return null;

  if (imageUrl.startsWith('http://')) {
    imageUrl = imageUrl.replaceFirst('http://', 'https://');
  }
  return imageUrl;
}

extension DoubleRounding on double {
  double roundTo(int places) {
    num mod = pow(10, places);
    return (this * mod).roundToDouble() / mod;
  }
}
