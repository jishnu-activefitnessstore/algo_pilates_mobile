import 'package:algo_pilates/src/features/home/presentation/widget/custom_html_widget.dart';
import 'package:algo_pilates/src/features/home/provider/home_provider.dart';
import 'package:algo_pilates/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
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

      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          return ListView(
            controller: _scrollController,
            padding: kDefaultPadding,
            children: [
              Container(
                padding: EdgeInsets.all(29),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.lightColor),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(provider.contactModel.title ?? "", style: AppStyles.getMediumTextStyle(fontSize: 24)),
                    CustomHtmlWidget(htmlString: provider.contactModel.description ?? ""),
                    // Text(
                    //   contactJson['description'],
                    //   style: AppStyles.getRegularTextStyle(fontSize: 14),
                    // ),
                    const SizedBox(height: 8),
                    if (provider.contactModel.phone != null)
                      getContactRow(
                        onTap: () => launchUrl(Uri.parse("TEL: +971503145585")),
                        title: "Phone",
                        subtitle: "+971 50 314 5585",
                        icon: AppImages.phone,
                      ),
                    if (provider.contactModel.email != null)
                      getContactRow(
                        onTap: () => launchUrl(Uri.parse("mailto:info@algopilates.com")),
                        title: "Email",
                        subtitle: "info@algopilates.com",
                        icon: AppImages.email,
                      ),
                    if (provider.contactModel.address != null)
                      getContactRow(
                        title: "Address",
                        subtitle: "Algo Pilates, Mezzanine Floor,\nJunction Mall DIP, Dubai.",
                        icon: AppImages.location,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              if (provider.contactModel.whatsapp != null) ...[
                Text(provider.contactModel.whatsapp!.title ?? "", style: AppStyles.getMediumTextStyle(fontSize: 24)),
                const SizedBox(height: 8),
                CustomHtmlWidget(htmlString: provider.contactModel.whatsapp!.description ?? ""),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    style: AppStyles.filledButton(
                      backgroundColor: AppColors.whatsapp,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    ),
                    onPressed: () {
                      final url = Uri.parse(
                        "https://api.whatsapp.com/send/?phone=${provider.contactModel.whatsapp!.whatsappNo}&text&type=phone_number&app_absent=0",
                      );
                      print(url);
                      launchUrl(url);
                    },
                    icon: SvgPicture.asset(AppImages.whatsapp, color: Colors.white, width: 30, height: 30),
                    label: Transform.translate(
                      offset: const Offset(0, 1),
                      child: Text(provider.contactModel.whatsapp!.buttonTitle ?? "", style: AppStyles.getMediumTextStyle(fontSize: 14)),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
            ],
          );
        },
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
