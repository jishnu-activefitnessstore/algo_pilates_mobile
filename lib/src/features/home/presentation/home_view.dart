import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:algo_pilates/src/features/home/presentation/widget/custom_scaffold.dart';
import 'package:algo_pilates/src/services/api_services.dart';
import 'package:algo_pilates/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String route = '/';
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  final PageController _pageController = PageController(initialPage: 999);
  int currentIndex = 0;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    currentIndex = 999;
    if (homeJson['slider'].length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 4), (_) {
        // if (currentIndex == homeJson['slider'].length - 1) {
        // currentIndex++;
        _pageController.animateToPage(currentIndex + 1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        // } else {
        //   _pageController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
        // }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _timer.cancel();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      path: HomeView.route,
      scrollController: _scrollController,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Slider
              SliverToBoxAdapter(
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) => currentIndex = value,
                    itemBuilder:
                        (context, index) => Stack(
                          children: [
                            Image.asset(
                              // AppImages.banner,
                              homeJson['slider'][index % homeJson['slider'].length]['imageUrl'],
                              alignment: Alignment(0.7, 0),
                              fit: BoxFit.cover,
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                            ),
                            Positioned(
                              bottom: constraints.maxHeight * 0.3,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Building\nLasting Strength\nThe Pilates Way",
                                      style: AppStyles.getBoldTextStyle(fontSize: 43, color: Colors.white),
                                    ),
                                    const SizedBox(height: 20),
                                    TextButton(
                                      style: AppStyles.filledButton(padding: EdgeInsets.all(8)),
                                      onPressed: () {},
                                      child: Row(
                                        spacing: 16,
                                        children: [
                                          Text("\t\t\t\tBook Now", style: AppStyles.getBoldTextStyle(fontSize: 14)),
                                          CircleAvatar(radius: 15, backgroundColor: Colors.white, child: Icon(Icons.arrow_right_alt)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                  ),
                ),
              ),
              // Description
              SliverPadding(
                padding: kDefaultPadding,
                sliver: SliverToBoxAdapter(
                  // child: Text(homeJson['description'], style: AppStyles.getLightTextStyle(fontSize: 14))
                  child: HtmlWidget(homeJson['description'], textStyle: AppStyles.getLightTextStyle(fontSize: 14)),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: kDefaultPadding,
                  color: AppColors.lightColor,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HtmlWidget(
                        homeJson['highlights'],
                        textStyle: AppStyles.getRegularTextStyle(fontSize: 14),
                        customStylesBuilder: (element) {
                          if (element.localName == 'h2') {
                            return {
                              'font-size': '28px', // font size
                              'font-weight': '600', // bold text
                              'margin': '0', // remove default margins
                            };
                          }
                          if (element.localName == 'h3') {
                            return {
                              'font-size': '24px', // font size
                              'font-weight': '500', // bold text
                              'margin': '0', // remove default margins
                            };
                          }
                          return null; // keep default for other tags
                        },
                      ),
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
                      ...List.generate(
                        homeJson['banners'].length,
                        (i) => getImage(
                          homeJson['banners'][i]['imageUrl'],
                          title: homeJson['banners'][i]['buttonTitle'],
                          url: homeJson['banners'][i]['url'],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          );
        },
      ),
    );
  }

  getImage(String image, {String? title, String? url}) => ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: IntrinsicHeight(
      child: Stack(
        children: [
          Image.asset(image),
          if (title != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withValues(alpha: 0.15),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15), // Frosted glass border
                        width: 1.5,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(title, style: AppStyles.getSemiBoldTextStyle(fontSize: 18, color: Colors.white)),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              try {
                                if (url != null) launchUrl(Uri.parse(url));
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.primaryColor,
                              radius: 30,
                              child: Transform.rotate(angle: math.pi * 3 / 4, child: Icon(Icons.arrow_back, size: 30, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

final Map<String, dynamic> homeJson = {
  "slider": [
    {"imageUrl": "assets/images/banner.jpg", "title": "Building\nLasting Strength\nThe Pilates Way", "showBookNow": true},
    {"imageUrl": "assets/images/banner.jpg", "title": "Building\nLasting Strength\nThe Pilates Way", "showBookNow": true},
  ],
  "description":
      "<p>With scientifically proven Pilates methods, our goal is to help clients build both mental and physical strength through Pilates and Athletic-Inspired Reformer classes. All low-impact and suitable for everyone, from beginners to professionals. Our signature classes, including Reformer Gym Vibes, blend intelligent movement with athletic energy. This is where you go beyond the basics of Pilates to unlock your highest potential. This isn’t just Pilates — it’s a movement revolution.</p>",
  "highlights":
      "<div><div><h2>Explore Our Signature</h2><h2>Class Formats</h2></div><div><p>From foundational control to high-performance training, each class is uniquely designed to elevate your Pilates experience. Whether you're just starting or advancing your practice, our signature formats help you build strength, balance, flexibility, and focus&mdash;one movement at a time.</p></div><h3>&nbsp;</h3><h3>Reformer</h3><h3>Gym Vibes</h3><div><p>Created by Anesti Mano with his background in bodybuilding, experience a powerful blend of gym-strength exercises and Pilates principles in this transformative class. With a focus on progressive overload and creative strength exercises for each muscle group, you'll work at a slow pace with high spring tension to maximize results.With classes and exercises personalized for all levels, Reformer Gym Vibes perfectly accommodates both beginners and advanced-level students.</p></div></div>",
  "banners": [
    {"imageUrl": "assets/images/Reformer-gym-vibes.jpg", "buttonTitle": null, "url": null},
    {
      "imageUrl": "assets/images/movement-principles.jpg",
      "buttonTitle": "Movement Principles",
      "url":
          "https://api.whatsapp.com/send/?phone=${ApiServices.whatsapp}&text=Hi%2C+I+need+this+course+details&type=phone_number&app_absent=0",
    },
    {
      "imageUrl": "assets/images/athletic-reformer.jpg",
      "buttonTitle": "Athletic Reformer",
      "url":
          "https://api.whatsapp.com/send/?phone=${ApiServices.whatsapp}&text=Hi%2C+I+need+this+course+details&type=phone_number&app_absent=0",
    },
    {
      "imageUrl": "assets/images/athletic-flow.jpg",
      "buttonTitle": "Athletic Flow",
      "url":
          "https://api.whatsapp.com/send/?phone=${ApiServices.whatsapp}&text=Hi%2C+I+need+this+course+details&type=phone_number&app_absent=0",
    },
  ],
};
