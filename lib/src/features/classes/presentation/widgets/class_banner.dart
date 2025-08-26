import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../utilities/utilities.dart';
import '../../../home/presentation/bookings_view.dart';

class ClassBanner extends StatelessWidget {
  const ClassBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black,
        gradient: RadialGradient(colors: [AppColors.secondaryBlue, Colors.black], radius: 0.8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Start Your Pilates\nClass Today!",
            style: AppStyles.getMediumTextStyle(fontSize: 24, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Expanded(
                child: TextButton.icon(
                  style: AppStyles.filledButton(backgroundColor: AppColors.whatsapp),
                  onPressed: () {},
                  label: Text("Contact Now", style: AppStyles.getRegularTextStyle(fontSize: 14, color: Colors.white)),
                  icon: SvgPicture.asset(AppImages.whatsapp, color: Colors.white, height: 20, width: 20),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: AppStyles.filledButton(),
                  onPressed: () {
                    context.pushNamed(BookingsView.route);
                  },
                  child: Row(
                    children: [
                      Spacer(),
                      Text("\t\t\t\tBook Now", style: AppStyles.getBoldTextStyle(fontSize: 14)),
                      Spacer(),
                      const CircleAvatar(radius: 12, backgroundColor: Colors.white, child: Icon(Icons.arrow_right_alt)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
