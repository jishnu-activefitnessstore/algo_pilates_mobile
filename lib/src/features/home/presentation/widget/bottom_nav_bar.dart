import 'dart:ui';

import 'package:algo_pilates/src/features/home/presentation/bookings_view.dart';
import 'package:algo_pilates/src/features/home/presentation/pricing_view.dart';
import 'package:algo_pilates/src/features/home/presentation/teams_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utilities/utilities.dart';
import '../home_view.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key, required this.currentIndex, required this.path});
  final int currentIndex;
  final String path;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: Padding(
        padding: EdgeInsets.all(16).copyWith(bottom: 32),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.secondaryColor.withOpacity(0.35), // Translucent glass
            // boxShadow: const [
            //   // Neumorphic shadows
            //   BoxShadow(color: Color(0x00BEBEBE), offset: Offset(10, 10), blurRadius: 20, spreadRadius: 1),
            //   BoxShadow(color: Colors.white12, offset: Offset(-10, -10), blurRadius: 20, spreadRadius: 1),
            // ],
            border: Border.all(
              color: Colors.white.withOpacity(0.3), // Frosted glass border
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: BottomNavigationBar(
                // backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                iconSize: 28,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(icon: getIcon(Icons.home), label: "HOME"),
                  BottomNavigationBarItem(icon: getIcon(Icons.attach_money), label: "PRICING"),
                  BottomNavigationBarItem(icon: getIcon(Icons.calendar_month), label: "BOOKINGS"),
                  BottomNavigationBarItem(icon: getIcon(Icons.diversity_3), label: "TEAM"),
                ],
                currentIndex: widget.currentIndex,
                onTap: navigate,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getIcon(IconData icon) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 4), child: Icon(icon));
  }

  navigate(int index) {
    print("index $index");
    switch (index) {
      case 0:
        if (widget.path != HomeView.route) {
          context.pushNamed(HomeView.route);
        }
        break;
      case 1:
        if (widget.path != PricingView.route) {
          context.pushNamed(PricingView.route);
        }
        break;
      case 2:
        if (widget.path != BookingsView.route) {
          context.pushNamed(BookingsView.route);
        }
        break;
      case 3:
        if (widget.path != TeamsView.route) {
          context.pushNamed(TeamsView.route);
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
