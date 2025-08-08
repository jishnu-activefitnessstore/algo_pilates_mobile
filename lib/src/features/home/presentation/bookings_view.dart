import 'package:algo_pilates/src/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'widget/custom_scaffold.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});
  static const String route = 'bookings';
  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  final ScrollController _scrollController = ScrollController();
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {},
              onHttpError: (HttpResponseError error) {},
              onWebResourceError: (WebResourceError error) {},
            ),
          );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadRequest(
        Uri.dataFromString('''<html>
              <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
              <body>
                <iframe src="https://app.glofox.com/portal/#/branch/67a1dab5e0c5726abe024ff1/classes-list-view" frameborder="0" width="100%" height="${MediaQuery.sizeOf(context).height}" style="border: none;   overflow: hidden;">
                </iframe>
              </body>
            </html>''', mimeType: 'text/html'),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      path: BookingsView.route,
      showBookNow: false,
      scrollController: _scrollController,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return WebViewWidget(controller: controller);
        },
      ),
    );
  }
}
