import 'package:algo_pilates/src/features/home/presentation/widget/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../bookings_view.dart';
import '../contact_view.dart';
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
    this.extendBodyBehindAppBar = false,
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
  final bool extendBodyBehindAppBar;
  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  late int currentIndex;
  late final scaffoldKey = widget.scaffoldKey ?? GlobalKey<ScaffoldState>();
  // double _scrollOffset = 0;
  @override
  void initState() {
    super.initState();
    // widget.scrollController.addListener(() {
    //   setState(() {
    //     _scrollOffset = widget.scrollController.offset;
    //   });
    // });
  }

  // double get _appBarOpacity => (_scrollOffset / 100).clamp(0.0, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: widget.bottomNavigationBar == null ? true : false,
      // extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      key: scaffoldKey,
      appBar:
          widget.appBar ??
          CustomAppbar(
            showBookNow: widget.showBookNow,
            // opacity: widget.extendBodyBehindAppBar ? _appBarOpacity : 1,
            opacity: 1,
          ),
      body: widget.body,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      bottomNavigationBar: widget.bottomNavigationBar ?? CustomNavBar(currentPath: widget.path),
    );
  }

  DateTime? lastBackPressed;
}
