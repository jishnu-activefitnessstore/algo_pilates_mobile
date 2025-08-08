import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/route_services.dart';
import '../presentation/no_internet_view.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _hasInternet = true;

  bool get hasInternet => _hasInternet;

  ConnectivityProvider() {
    initConnectivity();
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      debugPrint('Couldn\'t check connectivity status: $e');
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    _hasInternet = result.contains(ConnectivityResult.none);
    if (!_hasInternet) {
      _redirectToNoInternetView();
    } else {
      // Close the "No Internet" view if the connection is restored
      if (navigatorKey.currentContext != null) {
        if (ModalRoute.of(navigatorKey.currentContext!)?.settings.name == NoInternetView.route) {
          Navigator.of(navigatorKey.currentContext!).pop();
        }
      }
    }
    notifyListeners();
  }

  void _redirectToNoInternetView() {
    if (navigatorKey.currentContext != null && ModalRoute.of(navigatorKey.currentContext!)?.settings.name != NoInternetView.route) {
      navigatorKey.currentContext?.pushNamed(NoInternetView.route);
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
