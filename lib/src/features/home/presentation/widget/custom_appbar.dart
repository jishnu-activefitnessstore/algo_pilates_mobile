import 'package:algo_pilates/src/features/home/presentation/bookings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../utilities/utilities.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.showBookNow,
    required this.opacity, // NEW
  });

  final bool showBookNow;
  final double opacity; // NEW

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor.withValues(alpha: showBookNow ? opacity : 1),
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      surfaceTintColor: AppColors.secondaryColor,
      elevation: 0,
      title: Row(children: [SvgPicture.asset(AppImages.logoSvg, height: 30, alignment: Alignment.centerLeft)]),
      actions: [
        if (showBookNow)
          TextButton(
            style: AppStyles.filledButton(),
            onPressed: () {
              context.pushNamed(BookingsView.route);
            },
            child: Row(
              children: [
                Text("\t\t\t\tBook Now", style: AppStyles.getBoldTextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                const CircleAvatar(radius: 15, backgroundColor: Colors.white, child: Icon(Icons.arrow_right_alt)),
              ],
            ),
          ),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
