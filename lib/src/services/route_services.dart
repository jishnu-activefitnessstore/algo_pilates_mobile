import 'dart:io';

import 'package:algo_pilates/src/features/connectivity/presentation/no_internet_view.dart';
import 'package:algo_pilates/src/features/home/presentation/bookings_view.dart';
import 'package:algo_pilates/src/features/home/presentation/pricing_view.dart';
import 'package:algo_pilates/src/features/home/presentation/teams_view.dart';
import 'package:algo_pilates/src/features/splash/presentation/splash_screen_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/home/presentation/home_view.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final route = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: "/splash",
  routes: [
    GoRoute(
      path: HomeView.route,
      name: HomeView.route,
      pageBuilder: (context, state) => getCustomTransition(state, const HomeView()),
      routes: [
        GoRoute(
          path: SplashScreenView.route,
          name: SplashScreenView.route,
          pageBuilder: (context, state) => getCustomTransition(state, SplashScreenView()),
        ),
        GoRoute(
          path: NoInternetView.route,
          name: NoInternetView.route,
          pageBuilder: (context, state) => getCustomTransition(state, NoInternetView()),
        ),
        GoRoute(
          path: PricingView.route,
          name: PricingView.route,
          pageBuilder: (context, state) => getCustomTransition(state, PricingView()),
        ),
        GoRoute(
          path: BookingsView.route,
          name: BookingsView.route,
          pageBuilder: (context, state) => getCustomTransition(state, BookingsView()),
        ),
        GoRoute(path: TeamsView.route, name: TeamsView.route, pageBuilder: (context, state) => getCustomTransition(state, TeamsView())),
      ],
    ),
  ],
);
Page<dynamic> getCustomTransition(GoRouterState state, Widget child) {
  if (Platform.isAndroid) {
    return MaterialPage(key: state.pageKey, child: child);
  }
  return CupertinoPage(key: state.pageKey, child: child);
}

Page<dynamic> createSlideFromBottomRoute(GoRouterState state, Widget page) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

Page<dynamic> createFadeRoute(GoRouterState state, Widget page) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation), child: child);
    },
  );
}

Page<dynamic> createZoomRoute(GoRouterState state, Widget page) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation), child: child);
    },
  );
}
