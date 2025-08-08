import 'dart:async';

import 'package:algo_pilates/src/features/home/presentation/home_view.dart';
import 'package:algo_pilates/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});
  static String route = 'splash';
  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {});
    _timer = Timer(const Duration(seconds: 3), navigateAfterDelay);
  }

  navigateAfterDelay() {
    context.goNamed(HomeView.route);
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, body: Center(child: SvgPicture.asset(AppImages.logoSvg)));
  }
}
