import 'package:algo_pilates/src/features/home/models/pricing_model.dart';
import 'package:algo_pilates/src/features/home/provider/home_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
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
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          keys = List.generate(provider.pricingModel.classes!.length, (index) => GlobalKey());
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              // SliverToBoxAdapter(child : TitleBox(title: "Pricing & Packages", subtitle: "Home > Pricing & Packages")),
              SliverPadding(
                padding: kDefaultPadding,
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(provider.pricingModel.title ?? "", style: AppStyles.getSemiBoldTextStyle(fontSize: 24)),
                    const SizedBox(height: 16),
                    CustomHtmlWidget(htmlString: provider.pricingModel.description ?? ""),
                    const SizedBox(height: 20),
                    // Wrap(spacing: 8, runSpacing: 8, children: [getTab('Group Class', 0), getTab('Private Training Packages', 1)]),
                    // Wrap(
                    //   spacing: 8,
                    //   runSpacing: 8,
                    //   children: List.generate(provider.pricingModel.classes!!.length, (index) => getTab(provider.pricingModel.classes![index]['name'], index)),
                    // ),
                    SizedBox(
                      height: 35,
                      child: ListView.separated(
                        controller: _horizontalScrollController,
                        itemCount: provider.pricingModel.classes!.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          return getTab(provider.pricingModel.classes![index].name ?? "", index);
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
                      child: getListView(ValueKey(currentIndex), provider.pricingModel.classes![currentIndex].pricing!),
                    ),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  getListView(Key key, List<Pricing> models) => ListView.separated(
    key: key,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: models.length,
    padding: EdgeInsets.zero,
    separatorBuilder: (context, index) => const SizedBox(height: 16),
    itemBuilder: (context, index) {
      final model = models[index];
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(color: AppColors.lightColor.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(29),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: Transform.translate(offset: Offset(58, -58), child: CircleAvatar(radius: 80, backgroundColor: AppColors.lightColor)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  Text(model.name ?? "", style: AppStyles.getRegularTextStyle(fontSize: 16)),
                  Text('$currency ${model.price}', style: AppStyles.getSemiBoldTextStyle(fontSize: 25)),
                  Text(model.timePeriod ?? "", style: AppStyles.getRegularTextStyle(fontSize: 14)),
                  ...List.generate(
                    model.features!.length,
                    (i) => Text("• ${model.features![i]}", style: AppStyles.getRegularTextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    style: AppStyles.filledButton(),
                    onPressed: () {
                      launchUrl(
                        Uri.parse(
                          "https://api.whatsapp.com/send/?phone=${context.read<HomeProvider>().contactModel.whatsapp!.whatsappNo}&text=Hello, I am interested in registering for ${model.name}&type=phone_number&app_absent=0",
                        ),
                      );
                    },
                    child: Row(
                      spacing: 4,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppImages.whatsapp, color: Colors.white, height: 25, width: 25),
                        Transform.translate(
                          offset: const Offset(0, 2),
                          child: Text("Contact Now", style: AppStyles.getSemiBoldTextStyle(fontSize: 14)),
                        ),
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
      padding: EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.center,
      child: Text(title, style: AppStyles.getRegularTextStyle(fontSize: 13, color: currentIndex == index ? Colors.white : Colors.black)),
    ),
  );

  scrollToTaget(GlobalKey key) {
    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero, ancestor: null).dy + _horizontalScrollController.offset;
    _horizontalScrollController.animateTo(position, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
