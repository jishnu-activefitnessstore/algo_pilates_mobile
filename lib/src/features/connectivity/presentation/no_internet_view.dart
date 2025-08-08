import 'package:algo_pilates/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utilities/utilities.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});
  static String route = '/no-internet';
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        body: Padding(
          padding: kDefaultPadding,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
                const SizedBox(height: 20),
                Text('No Internet Connection', style: AppStyles.getBoldTextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text(
                  'Please check your network settings and try again.',
                  textAlign: TextAlign.center,
                  style: AppStyles.getRegularTextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Add logic to retry connection
                    if (context.findAncestorStateOfType<MyAppState>()!.hasInternet) {
                      context.pop();
                    }
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
