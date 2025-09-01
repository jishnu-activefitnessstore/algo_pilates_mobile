import 'package:algo_pilates/src/features/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utilities/utilities.dart';
import '../../../home/presentation/bookings_view.dart';
import '../../../home/presentation/contact_view.dart';

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
                child: TextButton(
                  style: AppStyles.filledButton(backgroundColor: AppColors.whatsapp),
                  onPressed: () {
                    launchUrl(
                      Uri.parse(
                        "https://api.whatsapp.com/send/?phone=${context.read<HomeProvider>().contactModel.whatsapp!.whatsappNo}&text=Hello, I am interested in registering for Pilates class}&type=phone_number&app_absent=0",
                      ),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.whatsapp, color: Colors.white, height: 24, width: 24),
                      const Spacer(flex: 1),
                      Transform.translate(
                        offset: const Offset(0, 1),
                        child: Text(
                          "Contact Now",
                          style: AppStyles.getLightTextStyle(fontSize: 14, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
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
                      const Spacer(),
                      Transform.translate(
                        offset: const Offset(0, 1),
                        child: Text("View Pricing", style: AppStyles.getLightTextStyle(fontSize: 14)),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(AppImages.rightArrowSvg, height: 20, width: 20),
                      ),
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
