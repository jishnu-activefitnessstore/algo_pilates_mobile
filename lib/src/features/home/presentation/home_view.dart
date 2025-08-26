import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:algo_pilates/src/features/classes/presentation/class_listitng_view.dart';
import 'package:algo_pilates/src/features/classes/provider/class_provider.dart';
import 'package:algo_pilates/src/features/home/presentation/widget/custom_scaffold.dart';
import 'package:algo_pilates/src/services/api_services.dart';
import 'package:algo_pilates/src/utilities/utilities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      path: HomeView.route,
      scrollController: _scrollController,
      extendBodyBehindAppBar: true,
      body: LayoutBuilder(
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
                        imageUrl: homeJson['top_banner']['imageUrl'],
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
                                homeJson['top_banner']['title'],
                                style: AppStyles.getBoldTextStyle(fontSize: 28, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              style: AppStyles.filledButton(padding: EdgeInsets.all(8)),
                              onPressed: () {
                                context.pushNamed(ClassListitngView.route);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 16,
                                children: [
                                  Text("\t\t\t\tExplore Classes", style: AppStyles.getMediumTextStyle(fontSize: 14)),
                                  CircleAvatar(radius: 15, backgroundColor: Colors.white, child: Icon(Icons.arrow_right_alt)),
                                ],
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
                  padding: kDefaultPadding,
                  // color: AppColors.lightColor,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHtmlWidget(htmlString: homeJson['description']),
                      if (homeJson['descImage'] != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: homeJson['descImage'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: constraints.maxHeight * 0.4,
                          ),
                        ),
                      CustomHtmlWidget(htmlString: homeJson['highlights']),
                      // Text(AppStrings.homeTitle1, style: AppStyles.getSemiBoldTextStyle(fontSize: 28)),
                      // Text(AppStrings.homeSubtitle1, style: AppStyles.getRegularTextStyle(fontSize: 14)),
                      // const SizedBox(height: 24),
                      // Text(AppStrings.homeTitle2, style: AppStyles.getMediumTextStyle(fontSize: 24)),
                      // Text(AppStrings.homeSubtitle2, style: AppStyles.getRegularTextStyle(fontSize: 14)),
                      const SizedBox(height: 24),
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
                      if (homeJson['show_classes'] == true)
                        Text(homeJson['classes_title'], style: AppStyles.getMediumTextStyle(fontSize: 22)),
                    ],
                  ),
                ),
              ),
              if (homeJson['show_classes'] == true && context.watch<ClassProvider>().classes.isNotEmpty)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: constraints.maxHeight * 0.5,
                    child: ListView.separated(
                      padding: kDefaultHorizontalPadding,
                      itemCount: context.watch<ClassProvider>().classes.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder:
                          (context, index) => getImage(
                            constraints: constraints,
                            classModel: context.watch<ClassProvider>().classes[index],
                            onTap:
                                () => context.pushNamed(
                                  ClassDetailsView.route,
                                  pathParameters: {'id': context.read<ClassProvider>().classes[index].id.toString()},
                                ),
                          ),
                    ),
                  ),
                ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          );
        },
      ),
    );
  }

  getImage({BoxConstraints? constraints, required ClassModel classModel, VoidCallback? onTap}) => SizedBox(
    height: (constraints!.maxHeight * 0.5),
    width: constraints.maxWidth * 0.625,
    child: ClassContainer(classModel: classModel, onTap: onTap),
  );
}

final Map<String, dynamic> homeJson = {
  "version": {"android_version": "1.0.0", "ios_version": "1.0.0", "isAndroidUpdateMandatory": true, "isIosUpdateMandatory": true},
  "top_banner": {
    "imageUrl": "https://algopilates.com/assets/image/app-hero.jpg",
    "title": "Building\nLasting Strength\nThe Pilates Way",
    "showBookNow": true,
  },

  "description":
      "<div><div><h2>Explore Our Signature</h2><h2>Class Formats</h2></div><div><p>From foundational control to high-performance training, each class is uniquely designed to elevate your Pilates experience. Whether you're just starting or advancing your practice, our signature formats help you build strength, balance, flexibility, and focus&mdash;one movement at a time.</p>",
  "descImage": "https://algopilates.com/assets/image/Reformer-gym-vibes.jpg",

  "highlights":
      "</div><h3>&nbsp;</h3><h3>Reformer</h3><h3>Gym Vibes</h3><div><p>Created by Anesti Mano with his background in bodybuilding, experience a powerful blend of gym-strength exercises and Pilates principles in this transformative class. With a focus on progressive overload and creative strength exercises for each muscle group, you'll work at a slow pace with high spring tension to maximize results.With classes and exercises personalized for all levels, Reformer Gym Vibes perfectly accommodates both beginners and advanced-level students.</p></div></div>",

  "show_classes": true,
  "classes_title": "More Classes",
};
