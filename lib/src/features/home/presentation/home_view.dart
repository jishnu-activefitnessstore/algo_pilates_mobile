import 'package:algo_pilates/src/features/classes/presentation/class_listitng_view.dart';
import 'package:algo_pilates/src/features/classes/provider/class_provider.dart';
import 'package:algo_pilates/src/features/home/presentation/widget/custom_scaffold.dart';
import 'package:algo_pilates/src/features/home/provider/home_provider.dart';
import 'package:algo_pilates/src/utilities/utilities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  YoutubePlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ClassProvider>().getClasses();
      final youtube = context.read<HomeProvider>().homeModel?.youtubeUrl;
      print("youtube: ${youtube?.mediaUrl}");
      if (youtube != null) {
        final fixedUrl = normalizeYoutubeUrl(youtube.mediaUrl!);

        final controller = YoutubePlayerController(
          initialVideoId: youtube.mediaUrl!,
          flags: YoutubePlayerFlags(autoPlay: false, mute: false),
        );

        if (mounted) {
          setState(() {
            _videoPlayerController = controller;
          });
        }
      }
    });
  }

  String normalizeYoutubeUrl(String url) {
    if (url.contains("youtu.be/")) {
      final videoId = url.split("youtu.be/").last;
      return "https://www.youtube.com/watch?v=$videoId";
    } else if (url.contains("shorts/")) {
      final videoId = url.split("shorts/").last.split("?").first;
      return "https://www.youtube.com/watch?v=$videoId";
    }
    return url;
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
                            imageUrl: provider.homeModel?.topBanner?.imageUrl ?? "",
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
                                    provider.homeModel?.topBanner?.title ?? "",
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
                          CustomHtmlWidget(htmlString: provider.homeModel?.description ?? ""),
                          if (provider.homeModel?.descImage != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: provider.homeModel!.descImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: constraints.maxHeight * 0.4,
                              ),
                            ),
                          CustomHtmlWidget(htmlString: provider.homeModel?.highlights ?? ""),

                          if (provider.homeModel?.showClasses == true)
                            Text(provider.homeModel?.classesTitle ?? "", style: AppStyles.getMediumTextStyle(fontSize: 24)),
                        ],
                      ),
                    ),
                  ),
                  if (provider.homeModel?.showClasses == true && context.watch<ClassProvider>().classModel.classes!.isNotEmpty)
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: constraints.maxHeight * 0.5,
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
                      ),
                    ),
                  if (_videoPlayerController != null)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: kDefaultHorizontalPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 24),
                            Text(provider.homeModel?.youtubeUrl?.title ?? "", style: AppStyles.getMediumTextStyle(fontSize: 24)),
                            SizedBox(height: 16),
                            // PodVideoPlayer(
                            //   controller: _videoPlayerController!,
                            //   videoThumbnail:
                            //       provider.homeModel?.youtubeUrl?.thumbnailUrl != null
                            //           ? DecorationImage(
                            //             image: CachedNetworkImageProvider(provider.homeModel?.youtubeUrl?.thumbnailUrl ?? ""),
                            //             fit: BoxFit.cover,
                            //           )
                            //           : null,
                            // ),
                            YoutubePlayer(
                              controller: _videoPlayerController!,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.amber,
                              progressColors: const ProgressBarColors(playedColor: Colors.amber, handleColor: Colors.amberAccent),
                              onReady: () {},
                            ),
                          ],
                        ),
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
