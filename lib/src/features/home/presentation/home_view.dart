import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:algo_pilates/src/features/classes/presentation/class_listitng_view.dart';
import 'package:algo_pilates/src/features/classes/provider/class_provider.dart';
import 'package:algo_pilates/src/features/home/presentation/widget/custom_scaffold.dart';
import 'package:algo_pilates/src/features/home/provider/home_provider.dart';
import 'package:algo_pilates/src/services/api_services.dart';
import 'package:algo_pilates/src/utilities/utilities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../classes/models/class_models.dart';
import '../../classes/presentation/class_details_view.dart';
import '../../classes/presentation/widgets/class_container.dart';
import 'widget/custom_html_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String route = '/';
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  // final PageController _pageController = PageController(initialPage: 999);
  // int currentIndex = 0;
  // late Timer _timer;
  PageController pageController = PageController(viewportFraction: 0.75);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClassProvider>().getClasses();
    });
    // currentIndex = 999;
    // if (homeJson['slider'].length > 1) {
    //   _timer = Timer.periodic(const Duration(seconds: 4), (_) {
    //     // if (currentIndex == homeJson['slider'].length - 1) {
    //     // currentIndex++;
    //     _pageController.animateToPage(currentIndex + 1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    //     // } else {
    //     //   _pageController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
    //     // }
    //   });
    // }
  }

  @override
  void dispose() {
    super.dispose();
    // _pageController.dispose();
    // _timer.cancel();
    _scrollController.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      path: HomeView.route,
      scrollController: _scrollController,
      extendBodyBehindAppBar: true,
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // Slider
                  // SliverToBoxAdapter(
                  //   child: SizedBox(
                  //     width: constraints.maxWidth,
                  //     height: constraints.maxHeight,
                  //     child: PageView.builder(
                  //       controller: _pageController,
                  //       onPageChanged: (value) => currentIndex = value,
                  //       itemBuilder:
                  //           (context, index) => Stack(
                  //             children: [
                  //               Image.asset(
                  //                 // AppImages.banner,
                  //                 homeJson['slider'][index % homeJson['slider'].length]['imageUrl'],
                  //                 // alignment: Alignment(0.0, 10),
                  //                 fit: BoxFit.cover,
                  //                 width: constraints.maxWidth,
                  //                 height: constraints.maxHeight,
                  //               ),
                  //               Positioned(
                  //                 bottom: constraints.maxHeight * 0.5,
                  //                 child: Padding(
                  //                   padding: EdgeInsets.symmetric(horizontal: 16),
                  //                   child: Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     children: [
                  //                       SizedBox(
                  //                         width: constraints.maxWidth,
                  //                         child: Text(
                  //                           "Building\nLasting Strength\nThe Pilates Way",
                  //                           style: AppStyles.getBoldTextStyle(fontSize: 28, color: Colors.white),
                  //                         ),
                  //                       ),
                  //                       const SizedBox(height: 20),
                  //                       TextButton(
                  //                         style: AppStyles.filledButton(padding: EdgeInsets.all(8)),
                  //                         onPressed: () {},
                  //                         child: Row(
                  //                           spacing: 16,
                  //                           children: [
                  //                             Text("\t\t\t\tBook Now", style: AppStyles.getBoldTextStyle(fontSize: 14)),
                  //                             CircleAvatar(radius: 15, backgroundColor: Colors.white, child: Icon(Icons.arrow_right_alt)),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //     ),
                  //   ),
                  // ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight / 2,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            // AppImages.banner,
                            imageUrl: provider.homeModel.topBanner?.imageUrl ?? "",
                            // alignment: Alignment(0.0, 10),
                            fit: BoxFit.cover,
                            width: constraints.maxWidth,
                            height: constraints.maxHeight / 2,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: constraints.maxWidth,
                                  child: Text(
                                    provider.homeModel.topBanner?.title ?? "",
                                    style: AppStyles.getRegularTextStyle(fontSize: 32, color: Colors.white).copyWith(height: 1.2),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  height: constraints.maxWidth * 0.1,
                                  constraints: BoxConstraints(maxHeight: 40),
                                  child: TextButton(
                                    style: AppStyles.filledButton(padding: EdgeInsets.all(8).copyWith(right: 4)),
                                    onPressed: () {
                                      context.pushNamed(ClassListitngView.route);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      spacing: 16,
                                      children: [
                                        Transform.translate(
                                          offset: const Offset(0, 1),
                                          child: Text(
                                            "\t\t\tExplore Classes",
                                            style: AppStyles.getRegularTextStyle(
                                              fontSize: constraints.maxWidth * 0.035 > 14 ? 14 : constraints.maxWidth * 0.035,
                                            ),
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(AppImages.rightArrowSvg, height: 15, width: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Description
                  // SliverPadding(
                  //   padding: kDefaultPadding,
                  //   sliver: SliverToBoxAdapter(
                  //     // child: Text(homeJson['description'], style: AppStyles.getLightTextStyle(fontSize: 14))
                  //     child: CustomHtmlWidget(htmlString: homeJson['description']),
                  //   ),
                  // ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: kDefaultPadding.copyWith(bottom: 12),
                      // color: AppColors.lightColor,
                      child: Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomHtmlWidget(htmlString: provider.homeModel.description ?? ""),
                          if (provider.homeModel.descImage != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: provider.homeModel.descImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: constraints.maxHeight * 0.4,
                              ),
                            ),
                          CustomHtmlWidget(htmlString: provider.homeModel.highlights ?? ""),
                          // Text(AppStrings.homeTitle1, style: AppStyles.getSemiBoldTextStyle(fontSize: 28)),
                          // Text(AppStrings.homeSubtitle1, style: AppStyles.getRegularTextStyle(fontSize: 14)),
                          // const SizedBox(height: 24),
                          // Text(AppStrings.homeTitle2, style: AppStyles.getMediumTextStyle(fontSize: 24)),
                          // Text(AppStrings.homeSubtitle2, style: AppStyles.getRegularTextStyle(fontSize: 14)),
                          // const SizedBox(height: 24),
                          // getImage(AppImages.homeImage1),
                          // getImage(AppImages.homeImage2, title: "Movement Principles"),
                          // getImage(AppImages.homeImage3, title: "Athletic Reformer"),
                          // getImage(AppImages.homeImage4, title: "Athletic Flow"),
                          // if (homeJson['classes'] != null)
                          //   ...List.generate(
                          //     homeJson['classes'].length,
                          //     (i) => getImage(
                          //       homeJson['classes'][i]['imageUrl'],
                          //       title: homeJson['classes'][i]['buttonTitle'],
                          //       onTap: () => homeJson['classes'][i]['url'],
                          //     ),
                          //   ),
                          if (provider.homeModel.showClasses == true)
                            Text(provider.homeModel.classesTitle ?? "", style: AppStyles.getMediumTextStyle(fontSize: 24)),
                        ],
                      ),
                    ),
                  ),
                  if (provider.homeModel.showClasses == true && context.watch<ClassProvider>().classModel.classes!.isNotEmpty)
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: constraints.maxHeight * 0.5,
                        // child: ListView.separated(
                        //   padding: kDefaultHorizontalPadding,
                        //   itemCount: context.watch<ClassProvider>().classModel.classes!.length,
                        //   scrollDirection: Axis.horizontal,
                        //   separatorBuilder: (_, __) => const SizedBox(width: 8),
                        //   itemBuilder:
                        //       (context, index) => getImage(
                        //         index: index,
                        //         constraints: constraints,
                        //         classModel: context.watch<ClassProvider>().classModel.classes![index],
                        //         onTap:
                        //             () => context.pushNamed(
                        //               ClassDetailsView.route,
                        //               pathParameters: {'id': context.read<ClassProvider>().classModel.classes![index].id.toString()},
                        //             ),
                        //       ),
                        // ),
                        child: PageView.builder(
                          itemCount: context.watch<ClassProvider>().classModel.classes!.length,
                          scrollDirection: Axis.horizontal,
                          pageSnapping: true,
                          controller: pageController,
                          // physics: CarouselScrollPhysics(),
                          onPageChanged: (value) => setState(() => sliderIndex = value),
                          padEnds: false,
                          itemBuilder:
                              (context, index) => getImage(
                                index: index,
                                constraints: constraints,
                                classModel: context.watch<ClassProvider>().classModel.classes![index],
                                onTap:
                                    () => context.pushNamed(
                                      ClassDetailsView.route,
                                      pathParameters: {'id': context.read<ClassProvider>().classModel.classes![index].id.toString()},
                                    ),
                              ),
                        ),
                        // child: CarouselView(
                        //   itemExtent: constraints.maxWidth * 2 / 3,
                        //   shrinkExtent: constraints.maxWidth * 2 / 3,
                        //   itemSnapping: true,
                        //   children: List.generate(
                        //     context.watch<ClassProvider>().classModel.classes!.length,
                        //     (i) => getImage(
                        //       index: i,
                        //       constraints: constraints,
                        //       classModel: context.watch<ClassProvider>().classModel.classes![i],
                        //       onTap:
                        //           () => context.pushNamed(
                        //             ClassDetailsView.route,
                        //             pathParameters: {'id': context.watch<ClassProvider>().classModel.classes![i].id.toString()},
                        //           ),
                        //     ),
                        //   ),
                        // ),
                        // child: FocusCarousel(
                        //   controller: controller,
                        //   itemExtent: constraints.maxWidth * 2 / 3,
                        //   shrinkExtent: constraints.maxWidth * 2 / 3,
                        //   items:
                        //       context.watch<ClassProvider>().classModel.classes!.map((c) {
                        //         return ClassContainer(
                        //           classModel: c,
                        //           onTap: () => context.pushNamed(ClassDetailsView.route, pathParameters: {'id': c.id.toString()}),
                        //         );
                        //       }).toList(),
                        // ),
                      ),
                    ),
                  SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              );
            },
          );
        },
      ),
    );
  }

  int sliderIndex = 0;
  final controller = CarouselController();

  getImage({required int index, BoxConstraints? constraints, required Classes classModel, VoidCallback? onTap}) => Center(
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: constraints!.maxHeight,
      // height: (constraints!.maxHeight * 0.5 - (sliderIndex == index ? 0 : 30)),
      width: constraints.maxWidth * 0.75,
      padding:
          index == 0
              ? EdgeInsets.only(left: 16)
              : index == context.watch<ClassProvider>().classModel.classes!.length - 1
              ? EdgeInsets.only(right: 16)
              : EdgeInsets.symmetric(horizontal: 16),
      child: ClassContainer(classModel: classModel, onTap: onTap),
    ),
  );
}

class FocusCarousel extends StatefulWidget {
  final List<Widget> items;
  final CarouselController controller;
  final double itemExtent;
  final double shrinkExtent;

  const FocusCarousel({super.key, required this.items, required this.itemExtent, required this.shrinkExtent, required this.controller});

  @override
  State<FocusCarousel> createState() => _FocusCarouselState();
}

class _FocusCarouselState extends State<FocusCarousel> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateIndex);
  }

  void _updateIndex() {
    final pos = widget.controller.position;
    if (pos.hasPixels) {
      final newIndex = (pos.pixels / widget.itemExtent).round();
      if (newIndex != _currentIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
      }
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateIndex);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: widget.itemExtent,
          child: CarouselView(
            controller: widget.controller,
            itemSnapping: true,
            itemExtent: widget.itemExtent,
            shrinkExtent: widget.shrinkExtent,
            backgroundColor: Colors.transparent,
            children:
                widget.items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final child = entry.value;
                  final bool isFocused = index == _currentIndex;
                  return Center(
                    child: AnimatedContainer(
                      height: (constraints.maxHeight - (isFocused ? 0 : 30)),
                      width: constraints.maxWidth * 0.6667,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      child: child,
                    ),
                  );
                }).toList(),
          ),
        );
      },
    );
  }
}
