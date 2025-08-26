import 'package:algo_pilates/src/utilities/constants.dart';
import 'package:algo_pilates/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/api_services.dart';
import 'widget/custom_scaffold.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});
  static const String route = 'contact-us';
  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      path: ContactView.route,
      scrollController: _scrollController,

      body: ListView(
        controller: _scrollController,
        padding: kDefaultPadding,
        children: [
          Container(
            padding: kDefaultPadding,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.lightColor),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Let’s Connect", style: AppStyles.getMediumTextStyle(fontSize: 24)),
                Text(
                  "Have questions or want to book your next Pilates session? We’re here to guide you toward balance, strength, and well-being.",
                  style: AppStyles.getRegularTextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                getContactRow(
                  onTap: () => launchUrl(Uri.parse("TEL: +971503145585")),
                  title: "Phone",
                  subtitle: "+971 50 314 5585",
                  icon: AppImages.phone,
                ),
                getContactRow(
                  onTap: () => launchUrl(Uri.parse("mailto:info@algopilates.com")),
                  title: "Email",
                  subtitle: "info@algopilates.com",
                  icon: AppImages.email,
                ),
                getContactRow(
                  title: "Address",
                  subtitle: "Algo Pilates, Mezzanine Floor,\nJunction Mall DIP, Dubai.",
                  icon: AppImages.location,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text("Chat with Us on WhatsApp", style: AppStyles.getMediumTextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text(
            "Have questions about our Pilates classes or schedule? Send us a message on WhatsApp and we’ll respond as soon as possible.",
            style: AppStyles.getLightTextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              style: AppStyles.filledButton(
                backgroundColor: AppColors.whatsapp,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {
                launchUrl(Uri.parse("https://api.whatsapp.com/send/?phone=${ApiServices.whatsapp}&text&type=phone_number&app_absent=0"));
              },
              icon: SvgPicture.asset(AppImages.whatsapp, color: Colors.white, width: 30, height: 30),
              label: Text("Chat on WhatsApp", style: AppStyles.getMediumTextStyle(fontSize: 14)),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  getContactRow({required String title, required String subtitle, required String icon, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.primaryColor,
            child: SvgPicture.asset(icon, color: Colors.white, height: 15, width: 15),
          ),
          const SizedBox(width: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppStyles.getMediumTextStyle(fontSize: 14, color: Color(0xff212529).withValues(alpha: 0.5))),
              Text(subtitle, style: AppStyles.getLightTextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
