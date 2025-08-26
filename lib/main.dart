import 'dart:async';

import 'package:algo_pilates/src/features/classes/provider/class_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/features/connectivity/presentation/no_internet_view.dart';
import 'src/features/home/provider/home_provider.dart';
import 'src/features/splash/presentation/splash_screen_view.dart';
import 'src/services/route_services.dart' as router;
import 'src/utilities/utilities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // Fetch token from SharedPreferences
  String? token = sharedPreferences.getString("token");
  print("token $token");
  // if (token != null) {
  //   ApiServices.headers['Authorization'] = 'Bearer $token';
  // }
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp(token: token));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.token});
  final String? token;

  @override
  State<MyApp> createState() => MyAppState();

  // Method to restart the app
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<MyAppState>()?.restartApp();
  }
}

class MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  late String? token = widget.token;
  late StreamSubscription<List<ConnectivityResult>> subscription;
  bool isFirstTime = true;
  bool hasInternet = true;

  void restartApp() {
    token = null;
    setState(() {
      key = UniqueKey();
    });
  }

  // late final FirebaseMessaging _messaging;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    // Connectivity
    subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      // Received changes in available connectivity types!
      _updateConnectionStatus(result);
    });
    // initFirebaseMessaging();
    // handleInitialMessage();
  }

  // initFirebaseMessaging() {
  //   _messaging = FirebaseMessaging.instance;

  //   // Request permissions (iOS)
  //   _messaging.requestPermission();

  //   // Initialize local notifications
  //   const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  //   const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
  //   final InitializationSettings initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS,
  //   );
  //   flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveNotificationResponse: (NotificationResponse response) {
  //       if (response.payload != null) {
  //         print('Notification tapped: ${response.payload}');
  //         final data = jsonDecode(response.payload!);
  //         final routeName = data['navigation_screen'];
  //         final type = data['type'];
  //         final status = data['status'];
  //         if (routeName != null) {
  //           navigatorKey.currentContext?.pushNamed(routeName, queryParameters: {'type': type, 'status': status});
  //         }
  //       }
  //     },
  //     onDidReceiveBackgroundNotificationResponse: (details) {
  //       if (details.payload != null) {
  //         print('Notification tapped: ${details.payload}');
  //         final data = jsonDecode(details.payload!);
  //         final routeName = data['navigation_screen'];
  //         final type = data['type'];
  //         final status = data['status'];
  //         if (routeName != null) {
  //           navigatorKey.currentContext?.goNamed(SplashScreen.route, queryParameters: {'route': routeName, 'type': type, 'status': status});
  //         }
  //       }
  //     },
  //   );

  //   // Listen for foreground messages
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       print(message.toMap());
  //       // Use a unique tag for each notification to prevent stacking/overwriting
  //       final uniqueTag = DateTime.now().millisecondsSinceEpoch.toString();
  //       flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         payload: jsonEncode(message.data),
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             'high_importance_channel',
  //             'High Importance Notifications',
  //             importance: Importance.high,
  //             priority: Priority.high,
  //             tag: uniqueTag, // Ensures every notification is unique
  //           ),
  //         ),
  //       );
  //     }
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print(message.data);
  //     final data = message.data;
  //     final routeName = data['navigation_screen'];
  //     final type = data['type'];
  //     final status = data['status'];

  //     if (routeName != null) {
  //       navigatorKey.currentContext?.pushNamed(routeName, queryParameters: {'type': type, 'status': status});
  //     }
  //   });
  // }

  // // Optionally, handle notification tap when app is terminated
  // void handleInitialMessage() async {
  //   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  //   if (initialMessage != null) {
  //     final data = initialMessage.data;
  //     final routeName = data['navigation_screen'];
  //     final type = data['type'];
  //     final status = data['status'];

  //     if (routeName != null) {
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         navigatorKey.currentContext?.goNamed(SplashScreen.route, queryParameters: {'route': routeName, 'type': type, 'status': status});
  //       });
  //     }
  //   }
  // }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none)) {
      hasInternet = false;
      _redirectToNoInternetView();
    } else {
      hasInternet = true;
      if (!isFirstTime) {
        isFirstTime = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (ModalRoute.of(router.navigatorKey.currentContext!)?.settings.name == NoInternetView.route) {
            Navigator.of(router.navigatorKey.currentContext!).pop();
          }
        });
      }
    }
  }

  void _redirectToNoInternetView() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final routeName = router.route.routerDelegate.currentConfiguration.last.route.name;
      if (routeName != NoInternetView.route && routeName != SplashScreenView.route) {
        router.navigatorKey.currentContext!.pushNamed(NoInternetView.route);
      }
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: MaterialApp.router(
        title: 'Algo Pilates',
        // Turn off for production
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          useMaterial3: true,
          dividerTheme: DividerThemeData(color: AppColors.borderColor),

          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withValues(alpha: 0.6),
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedLabelStyle: AppStyles.getBoldTextStyle(fontSize: 13),
            unselectedLabelStyle: AppStyles.getRegularTextStyle(fontSize: 13),
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              // Set the predictive back transitions for Android.
              TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
            },
          ),
          datePickerTheme: DatePickerThemeData(
            rangePickerHeaderBackgroundColor: AppColors.primaryColor,
            rangePickerHeaderForegroundColor: Colors.white,
          ),
        ),

        // routing
        routerDelegate: router.route.routerDelegate,
        routeInformationParser: router.route.routeInformationParser,
        routeInformationProvider: router.route.routeInformationProvider,

        // Localization
        // locale: context.watch<LanguageProvider>().currentLocale,
        // localizationsDelegates: AppLocalizations.localizationsDelegates,
        // supportedLocales: AppLocalizations.supportedLocales,
        builder:
            (context, child) => MultiProvider(
              providers: [
                // ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider(token: token)),
                // ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
                ChangeNotifierProvider<HomeProvider>(create: (context) => HomeProvider()),
                ChangeNotifierProvider<ClassProvider>(create: (context) => ClassProvider()),
                // ChangeNotifierProvider<ApprovalProvider>(create: (context) => ApprovalProvider()),
                // ChangeNotifierProvider<RequestProvider>(create: (context) => RequestProvider()),
              ],
              child: child,
            ),
      ),
    );
  }
}
