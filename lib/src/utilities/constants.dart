import 'package:flutter/widgets.dart';

enum Gender { male, female }

enum OtpMethod { sms, whatsapp, email }

final kDefaultPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 24);
final kDefaultHorizontalPadding = const EdgeInsets.symmetric(horizontal: 15);

String currency = "AED";
String countryCode = 'ae';
String languageCode = 'en';

final redStings = ["loss_of_pay", "comp_off_rejected", "annual_leave_rejected", "sick_leave_rejected", "a"];
final greenString = ["comp_off_requested", "annual_leave_requested", "sick_leave_requested", "p"];
