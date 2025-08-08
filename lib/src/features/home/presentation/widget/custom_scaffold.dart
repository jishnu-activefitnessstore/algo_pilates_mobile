import 'package:algo_pilates/src/features/home/presentation/widget/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../bookings_view.dart';
import '../home_view.dart';
import '../pricing_view.dart';
import '../teams_view.dart';
import 'bottom_nav_bar.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({
    super.key,
    this.scaffoldKey,
    required this.path,
    required this.body,
    required this.scrollController,
    this.showBookNow = true,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });
  final String path;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool showBookNow;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final ScrollController scrollController;
  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  late int currentIndex;
  late final scaffoldKey = widget.scaffoldKey ?? GlobalKey<ScaffoldState>();
  double _scrollOffset = 0;
  @override
  void initState() {
    super.initState();
    getCurrentIndex();
    widget.scrollController.addListener(() {
      setState(() {
        _scrollOffset = widget.scrollController.offset;
      });
    });
  }

  double get _appBarOpacity => (_scrollOffset / 100).clamp(0.0, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: widget.showBookNow,
      key: scaffoldKey,
      appBar: widget.appBar ?? CustomAppbar(showBookNow: widget.showBookNow, opacity: _appBarOpacity),
      body: widget.body,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      bottomNavigationBar: widget.bottomNavigationBar ?? CustomNavBar(currentIndex: currentIndex, path: widget.path),
    );
  }

  DateTime? lastBackPressed;

  getCurrentIndex() {
    switch (widget.path) {
      case HomeView.route:
        currentIndex = 0;
        break;
      case PricingView.route:
        currentIndex = 1;
        break;
      case BookingsView.route:
        currentIndex = 2;
        break;
      case TeamsView.route:
        currentIndex = 3;
        break;
      default:
        currentIndex = 0;
    }
  }
}
