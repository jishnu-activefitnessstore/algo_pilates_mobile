import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../utilities/utilities.dart';

class ApiServices {
  static const String baseUrl = 'https://empapi.afsdev.in/api';
  static const String whatsapp = '971503145585';

  static Map<String, String> headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};

  static const Map<String, dynamic> defaultError = {"status": "Failed", "message": "An error occurred, please try again"};

  static String iframeElement(double height) =>
      '<iframe src="https://app.glofox.com/portal/#/branch/67a1dab5e0c5726abe024ff1/classes-list-view" frameborder="0" width="100%" height="$height"></iframe><a href="https://www.glofox.com">powered by <b>Glofox</b></a>';

  /// Auth API
  // Future<Map<String, dynamic>> login({required Map<String, String> params}) async {
  //   var request = http.MultipartRequest('POST', Uri.parse("$baseUrl/login"));
  //   request.fields.addAll(params);
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   log("login ${response.statusCode}");
  //   return getResponseBody(response);
  // }

  // Future<Map<String, dynamic>> getResponseBody(http.StreamedResponse response) async {
  //   // bool userDataFirstTime = navigatorKey.currentContext!.read<UserProvider>().userModel == null;
  //   if (response.statusCode == 401 && response.request?.url.toString().contains('logout') != true) {
  //     // print();
  //     handle401();
  //     return {};
  //   }
  //   try {
  //     final String data = await response.stream.bytesToString();
  //     return jsonDecode(data);
  //   } catch (e) {
  //     log('Error parsing response: ${response.statusCode}');
  //     return defaultError;
  //   }
  // }

  // Future<dynamic> getImageWithAuth(String url, String token) async {
  //   final response = await http.get(
  //     Uri.parse(getProfilePic(url)),
  //     headers: {
  //       "Authorization": "Bearer $token",
  //       "Accept": "*/*", // Or the specific image type you expect
  //     },
  //   );

  //   log("getImageWithAuth ${response.statusCode}");

  //   if (response.statusCode == 200) {
  //     return response.bodyBytes;
  //   } else {
  //     log("Failed to fetch image: ${response.statusCode} - ${response.body}");
  //     return null;
  //   }
  // }

  // handle401() => navigatorKey.currentContext!.read<AuthProvider>().logout(navigatorKey.currentContext!);
}
