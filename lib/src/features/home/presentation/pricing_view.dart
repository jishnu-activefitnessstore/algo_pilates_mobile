import 'package:algo_pilates/src/features/home/models/package_model.dart';
import 'package:algo_pilates/src/services/api_services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget/custom_html_widget.dart';
import 'widget/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../utilities/utilities.dart';

class PricingView extends StatefulWidget {
  const PricingView({super.key});
  static const String route = 'pricing';
  @override
  State<PricingView> createState() => _PricingViewState();
}

class _PricingViewState extends State<PricingView> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();
  int currentIndex = 0;
  List<GlobalKey> keys = [];

  @override
  void initState() {
    keys = List.generate(pricingJson['classes'].length, (index) => GlobalKey());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _horizontalScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      scrollController: _scrollController,
      path: PricingView.route,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // SliverToBoxAdapter(child : TitleBox(title: "Pricing & Packages", subtitle: "Home > Pricing & Packages")),
          SliverPadding(
            padding: kDefaultPadding,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(pricingJson['title'], style: AppStyles.getSemiBoldTextStyle(fontSize: 24)),
                const SizedBox(height: 24),
                CustomHtmlWidget(htmlString: pricingJson['description']),
                const SizedBox(height: 30),
                // Wrap(spacing: 8, runSpacing: 8, children: [getTab('Group Class', 0), getTab('Private Training Packages', 1)]),
                // Wrap(
                //   spacing: 8,
                //   runSpacing: 8,
                //   children: List.generate(pricingJson['classes']!.length, (index) => getTab(pricingJson['classes'][index]['name'], index)),
                // ),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    controller: _horizontalScrollController,
                    itemCount: pricingJson['classes'].length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return getTab(pricingJson['classes'][index]['name'], index);
                    },
                  ),
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
    key: key,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: models.length,
    padding: EdgeInsets.zero,
    separatorBuilder: (context, index) => const SizedBox(height: 16),
    itemBuilder: (context, index) {
      final model = models[index];
      return Container(
        decoration: BoxDecoration(color: AppColors.lightColor.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: Transform.translate(offset: Offset(48, -48), child: CircleAvatar(radius: 80, backgroundColor: AppColors.lightColor)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  Text(model.name, style: AppStyles.getRegularTextStyle(fontSize: 18)),
                  Text('$currency ${model.price}', style: AppStyles.getSemiBoldTextStyle(fontSize: 32)),
                  Text(model.timePeriod, style: AppStyles.getRegularTextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  ...List.generate(
                    model.features.length,
                    (i) => Text("• ${model.features[i]}", style: AppStyles.getRegularTextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    style: AppStyles.filledButton(),
                    onPressed: () {
                      launchUrl(
                        Uri.parse("https://api.whatsapp.com/send/?phone=${ApiServices.whatsapp}&text&type=phone_number&app_absent=0"),
                      );
                    },
                    child: Row(
                      spacing: 4,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppImages.whatsapp, color: Colors.white, height: 25, width: 25),
                        Text("Contact Now", style: AppStyles.getSemiBoldTextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  getTab(String title, int index) => InkWell(
    key: keys[index],
    onTap: () {
      scrollToTaget(keys[index]);
      setState(() => currentIndex = index);
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: currentIndex == index ? AppColors.primaryColor : AppColors.lightColor,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(title, style: AppStyles.getMediumTextStyle(fontSize: 14, color: currentIndex == index ? Colors.white : Colors.black)),
    ),
  );

  scrollToTaget(GlobalKey key) {
    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero, ancestor: null).dy + _horizontalScrollController.offset;
    _horizontalScrollController.animateTo(position, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}

final Map<String, dynamic> pricingJson = {
  "title": "Price & Packages ",
  "description": "</p>To get more details about our price and packages, please contact our studio</p>",
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
