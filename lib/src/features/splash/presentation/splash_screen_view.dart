import 'dart:async';
import 'dart:io';

import 'package:algo_pilates/src/features/home/presentation/home_view.dart';
import 'package:algo_pilates/src/features/home/provider/home_provider.dart';
import 'package:algo_pilates/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});
  static String route = 'splash';
  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {});
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigateAfterDelay());
  }

  void _navigateAfterDelay() async {
    final stopwatch = Stopwatch()..start();

    final provider = context.read<HomeProvider>();
    await provider.getJsons();
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      final String androidVersion = provider.homeModel.version!.androidVersion!;
      final String iosVersion = provider.homeModel.version!.iosVersion!;
      final currentAndroidVersion = Version.parse(normalizeVersion(androidVersion));
      final currentiOSVersion = Version.parse(normalizeVersion(iosVersion));
      final latestVersion = Version.parse(version);

      if (Platform.isAndroid && currentAndroidVersion > latestVersion) {
        await showVersionAlertDialog(provider.homeModel.version!.isAndroidUpdateMandatory!);
      }
      if (Platform.isIOS && currentiOSVersion > latestVersion) {
        await showVersionAlertDialog(provider.homeModel.version!.isIosUpdateMandatory!);
      }
    } catch (e) {
      print(e);
    }
    stopwatch.stop();

    int remainingTime = 2000 - stopwatch.elapsedMilliseconds;
    if (remainingTime > 0) {
      await Future.delayed(Duration(milliseconds: remainingTime));
    }
    if (mounted) {
      context.goNamed(HomeView.route);
    }
  }

  showVersionAlertDialog(bool isMandatory) async {
    return await showAdaptiveDialog(
      context: context,
      barrierDismissible: !isMandatory,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text("Update Available", style: AppStyles.getMediumTextStyle(fontSize: 18)),
          content: Text(
            "A new version of the app is available. Please update to continue.",
            style: AppStyles.getRegularTextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Navigate to app store or play store
                if (Platform.isAndroid) {
                  // Replace with your app's Play Store URL
                  // launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.activefitnessstore.hrm.app"));
                  launchUrl(Uri.parse("https://drive.google.com/drive/folders/17Kh2tMAeEd-lr879Gs_cEjgFaXhQ3ken?usp=sharing"));
                } else if (Platform.isIOS) {
                  // Replace with your app's App Store URL
                  launchUrl(Uri.parse("https://apps.apple.com/app/6746353186"));
                }
              },
              child: Text("Update", style: AppStyles.getBoldTextStyle(fontSize: 14)),
            ),
            TextButton(
              onPressed: () {
                // Exit the app
                if (isMandatory) {
                  exit(0);
                } else {
                  context.pop();
                }
              },
              child: Text(isMandatory ? "Exit" : "Cancel", style: AppStyles.getBoldTextStyle(fontSize: 14)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, body: Center(child: SvgPicture.asset(AppImages.logoSvg)));
  }
}
