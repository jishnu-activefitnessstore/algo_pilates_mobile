import 'dart:ui';

import 'package:algo_pilates/src/features/home/presentation/bookings_view.dart';
import 'package:algo_pilates/src/features/home/presentation/contact_view.dart';
import 'package:algo_pilates/src/features/home/presentation/pricing_view.dart';
import 'package:algo_pilates/src/features/home/presentation/teams_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../utilities/utilities.dart';
import '../home_view.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key, required this.currentPath});
  final String currentPath;
  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // image: DecorationImage(image: image)
        // color: AppColors.secondaryColor,
        gradient: AppColors.bottomBarGradient,
      ),
      padding: EdgeInsets.only(top: 8),
      child: PlainNavBar(currentPath: widget.currentPath),
    );
  }
}

class PlainNavBar extends StatefulWidget {
  const PlainNavBar({super.key, required this.currentPath});
  final String currentPath;

  @override
  State<PlainNavBar> createState() => PlainNavBarState();
}

class PlainNavBarState extends State<PlainNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      iconSize: 25,
      elevation: 0,
      items: [
        BottomNavigationBarItem(icon: getIcon(AppImages.team), label: "TEAM"),
        BottomNavigationBarItem(icon: getIcon(AppImages.pricing), label: "PRICING"),
        BottomNavigationBarItem(icon: getIcon(AppImages.home), label: "HOME"),
        BottomNavigationBarItem(icon: getIcon(AppImages.bookings), label: "BOOK NOW"),
        BottomNavigationBarItem(icon: getIcon(AppImages.contact), label: "CONTACT"),
      ],
      currentIndex: getCurrentIndex(),
      onTap: navigate,
    );
  }

  Widget getIcon(String icon) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 4), child: SvgPicture.asset(icon, color: Colors.white, height: 25, width: 25));
  }

  int getCurrentIndex() => switch (widget.currentPath) {
    TeamsView.route => 0,
    PricingView.route => 1,
    HomeView.route => 2,
    BookingsView.route => 3,
    ContactView.route => 4,
    _ => 0,
  };

  navigate(int index) {
    print("index $index");
    switch (index) {
      case 0:
        if (widget.currentPath != TeamsView.route) {
          context.pushNamed(TeamsView.route);
        }
        break;
      case 1:
        if (widget.currentPath != PricingView.route) {
          context.pushNamed(PricingView.route);
        }
        break;
      case 2:
        if (widget.currentPath != HomeView.route) {
          context.pushNamed(HomeView.route);
        }
        break;
      case 3:
        if (widget.currentPath != BookingsView.route) {
          context.pushNamed(BookingsView.route);
        }
      case 4:
        if (widget.currentPath != ContactView.route) {
          context.pushNamed(ContactView.route);
        }
        break;
      // case 3:
      //   if (context.read<UserProvider>().userModel?.permission?.contains('manager') != true && widget.path != ProfileView.route) {
      //     context.pushNamed(ProfileView.route);
      //   } else if (widget.path != ApprovalView.route && context.read<UserProvider>().userModel?.permission?.contains('manager') == true) {
      //     context.pushNamed(ApprovalView.route);
      //   }
      //   break;
      // case 4:
      //   if (widget.path != ProfileView.route) {
      //     context.pushNamed(ProfileView.route);
      //   }
      //   break;
      default:
        break;
    }
  }
}
