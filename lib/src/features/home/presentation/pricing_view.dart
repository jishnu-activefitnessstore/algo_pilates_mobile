import 'package:algo_pilates/src/features/home/models/package_model.dart';
import 'package:algo_pilates/src/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../utilities/utilities.dart';
import 'widget/title_box.dart';

class PricingView extends StatefulWidget {
  const PricingView({super.key});
  static const String route = 'pricing';
  @override
  State<PricingView> createState() => _PricingViewState();
}

class _PricingViewState extends State<PricingView> {
  final ScrollController _scrollController = ScrollController();
  int currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      scrollController: _scrollController,
      path: PricingView.route,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(child: TitleBox(title: "Pricing & Packages", subtitle: "Home > Pricing & Packages")),
          SliverPadding(
            padding: kDefaultPadding,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(AppStrings.pricingTitle1, style: AppStyles.getSemiBoldTextStyle(fontSize: 32)),
                const SizedBox(height: 24),
                Text(AppStrings.pricingDesc1, style: AppStyles.getRegularTextStyle(fontSize: 16)),
                const SizedBox(height: 30),
                // Wrap(spacing: 8, runSpacing: 8, children: [getTab('Group Class', 0), getTab('Private Training Packages', 1)]),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(pricingJson['classes']!.length, (index) => getTab(pricingJson['classes'][index]['name'], index)),
                ),
                const SizedBox(height: 24),
                // AnimatedCrossFade(
                //   firstChild: getListView(ValueKey(0), groupClass),
                //   secondChild: getListView(ValueKey(1), privateClass),
                //   crossFadeState: currentIndex == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                //   duration: const Duration(milliseconds: 300),
                // ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    final offsetAnimation = Tween<Offset>(
                      begin: const Offset(1.0, 0.0), // start from right
                      end: Offset.zero, // end at normal position
                    ).animate(animation);

                    return SlideTransition(position: offsetAnimation, child: child);
                  },
                  child: getListView(
                    ValueKey(currentIndex),
                    pricingJson['classes'][currentIndex]['pricing'].map<PackageModel>((e) => PackageModel.fromJson(e)).toList(),
                  ),
                ),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  getListView(Key key, List<PackageModel> models) => ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: models.length,
    padding: EdgeInsets.zero,
    separatorBuilder: (context, index) => const SizedBox(height: 16),
    itemBuilder: (context, index) {
      final model = models[index];
      return Container(
        decoration: BoxDecoration(color: AppColors.lightColor, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            Text(model.name, style: AppStyles.getRegularTextStyle(fontSize: 18)),
            Text('$currency ${model.price}', style: AppStyles.getSemiBoldTextStyle(fontSize: 32)),
            Text(model.timePeriod, style: AppStyles.getRegularTextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            ...List.generate(
              model.features.length,
              (i) => Text("• ${model.features[i]}", style: AppStyles.getRegularTextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 8),
            TextButton(
              style: AppStyles.filledButton(),
              onPressed: () {
                launchUrl(Uri.parse("https://api.whatsapp.com/send/?phone=${ApiServices.whatsapp}&text&type=phone_number&app_absent=0"));
              },
              child: Text("Buy Now", style: AppStyles.getSemiBoldTextStyle(fontSize: 16)),
            ),
          ],
        ),
      );
    },
  );

  getTab(String title, int index) => InkWell(
    onTap: () => setState(() => currentIndex = index),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: currentIndex == index ? AppColors.primaryColor : AppColors.lightColor,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(title, style: AppStyles.getMediumTextStyle(fontSize: 14, color: currentIndex == index ? Colors.white : Colors.black)),
    ),
  );
}

final Map<String, dynamic> pricingJson = {
  "title": "Our Class Packages",
  "description":
      "</p>Explore our flexible class packages designed to match your fitness goals and lifestyle. Whether you're just starting out or looking to stay consistent, we have something perfect for you. Contact us now for exclusive offers on class packs Call or WhatsApp us today</p>",
  "classes": [
    {
      "name": "Group Class",
      "pricing": [
        {
          "name": "Single Class",
          "price": 195.0,
          "time_period": "7 Days",
          "features": ["1 group session", "Certified trainer", "Access to any open class"],
        },
        {
          "name": "5 Class Pack",
          "price": 895.0,
          "time_period": "20 Days",
          "features": ["5 group sessions", "Flexible timing", "Beginner to advanced levels"],
        },
        {
          "name": "10 Class Pack",
          "price": 1695.0,
          "time_period": "30 Days",
          "features": ["10 sessions", "Priority booking", "Free guest pass"],
        },
        {
          "name": "15 Class Pack",
          "price": 2295.0,
          "time_period": "45 Days",
          "features": ["15 sessions", "Progress tracking", "Water & towel service"],
        },
        {
          "name": "20 Class Pack",
          "price": 2895.0,
          "time_period": "45 Days",
          "features": ["20 sessions", "Extended booking window", "2 free guest passes"],
        },
        {
          "name": "Monthly Membership",
          "price": 3995.0,
          "time_period": "30 Days",
          "features": ["Unlimited classes", "VIP access", "10% off in-studio purchases"],
        },
      ],
    },
    {
      "name": "Private Training Packages",
      "pricing": [
        {
          "name": "Private - Single Class",
          "price": 495.0,
          "time_period": "7 Days",
          "features": ["1 private session", "Certified personal trainer", "Tailored to your goals"],
        },
        {
          "name": "Private - 5 Class Pack",
          "price": 2295.0,
          "time_period": "15 Days",
          "features": ["5 private sessions", "One-on-one coaching", "Flexible schedule"],
        },
        {
          "name": "Private - 10 Class Pack",
          "price": 3995.0,
          "time_period": "20 Days",
          "features": ["10 private sessions", "Dedicated personal trainer", "Progress tracking included"],
        },
        {
          "name": "Private - 20 Class Pack",
          "price": 6995.0,
          "time_period": "35 Days",
          "features": ["20 private sessions", "Comprehensive goal plan", "Priority scheduling"],
        },
      ],
    },
  ],
};
