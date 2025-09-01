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
      title: Row(children: [SvgPicture.asset(AppImages.logoSvg, height: 29, alignment: Alignment.centerLeft)]),
      actions: [
        if (showBookNow)
          SizedBox(
            height: 35,
            child: TextButton(
              style: AppStyles.filledButton(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0)),
              onPressed: () {
                context.pushNamed(BookingsView.route);
              },
              child: Row(
                children: [
                  Transform.translate(
                    offset: Offset(0, 1),
                    child: Text("\t\tBook Now", style: AppStyles.getRegularTextStyle(fontSize: 14)),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset(AppImages.rightArrowSvg, height: 15, width: 15),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
