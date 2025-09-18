import 'package:algo_pilates/src/features/home/presentation/widget/bottom_nav_bar.dart';
import 'package:algo_pilates/src/features/home/provider/home_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import 'widget/custom_scaffold.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});
  static const String route = 'bookings';
  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  final ScrollController _scrollController = ScrollController();
  // late WebViewController controller;

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    verticalScrollBarEnabled: false,
    horizontalScrollBarEnabled: false,
    isTextInteractionEnabled: true,
    isInspectable: true,
    javaScriptEnabled: true,
    domStorageEnabled: true,
    transparentBackground: true,
    allowsInlineMediaPlayback: true,
    needInitialFocus: true,
    saveFormData: true,

    javaScriptCanOpenWindowsAutomatically: true,
    allowsAirPlayForMediaPlayback: true,
    allowUniversalAccessFromFileURLs: true,
    allowFileAccessFromFileURLs: true,

    cacheEnabled: true,
    clearCache: false,
  );

  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    super.initState();
    // controller =
    //     WebViewController()
    //       ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //       ..setNavigationDelegate(
    //         NavigationDelegate(
    //           onProgress: (int progress) {
    //             // Update loading bar.
    //           },
    //           onPageStarted: (String url) {
    //             print(url);
    //           },
    //           onPageFinished: (String url) {},
    //           onHttpError: (HttpResponseError error) {},
    //           onWebResourceError: (WebResourceError error) {},
    //         ),
    //       );
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controller.loadRequest(
    //     Uri.dataFromString('''<html>
    //           <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
    //           <body>
    //             <iframe src="https://app.glofox.com/portal/#/branch/67a1dab5e0c5726abe024ff1/classes-list-view" frameborder="0" width="100%" height="${MediaQuery.sizeOf(context).height}" style="border: none;   overflow: hidden;">
    //             </iframe>
    //           </body>
    //         </html>''', mimeType: 'text/html'),
    //   );
    // });

    pullToRefreshController =
        kIsWeb || ![TargetPlatform.iOS, TargetPlatform.android].contains(defaultTargetPlatform)
            ? null
            : PullToRefreshController(
              settings: PullToRefreshSettings(color: Colors.blue),
              onRefresh: () async {
                if (defaultTargetPlatform == TargetPlatform.android) {
                  webViewController?.reload();
                } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                  webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
                }
              },
            );
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
          // return WebViewWidget(controller: controller);
          return InAppWebView(
            key: webViewKey,

            // webViewEnvironment: webViewEnvironment,
            initialUrlRequest: URLRequest(
              url: WebUri(context.watch<HomeProvider>().homeModel?.bookingUrl ?? "https://algopilates.com/pricing"),
            ),
            initialSettings: settings,
            pullToRefreshController: pullToRefreshController,
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
          );
        },
      ),
    );
  }
}
