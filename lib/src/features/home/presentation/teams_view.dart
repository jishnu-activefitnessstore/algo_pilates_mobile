import 'package:algo_pilates/src/features/home/models/team_model.dart';
import 'package:algo_pilates/src/features/home/presentation/widget/custom_html_widget.dart';
import 'package:algo_pilates/src/features/home/provider/home_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/utilities.dart';
import 'widget/custom_scaffold.dart';
import 'widget/title_box.dart';

class TeamsView extends StatefulWidget {
  const TeamsView({super.key});
  static const String route = 'teams';
  @override
  State<TeamsView> createState() => _TeamsViewState();
}

class _TeamsViewState extends State<TeamsView> {
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
      path: TeamsView.route,
      scrollController: _scrollController,
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              // SliverToBoxAdapter(child: TitleBox(title: "Our Team", subtitle: "Home > Our Team")),
              SliverPadding(
                padding: kDefaultPadding,
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(provider.teamModel.title ?? "", style: AppStyles.getSemiBoldTextStyle(fontSize: 25)),
                    const SizedBox(height: 16),
                    CustomHtmlWidget(htmlString: provider.teamModel.description ?? ""),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 100,
                      child: Center(
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.teamModel.members!.length,
                          separatorBuilder: (context, index) => const SizedBox(width: 8),
                          itemBuilder:
                              (context, index) => InkWell(
                                splashFactory: NoSplash.splashFactory,
                                radius: 50,
                                onTap: () {
                                  setState(() => currentIndex = index);
                                },
                                child: CircleAvatar(
                                  radius: currentIndex == index ? 50 : 40,
                                  foregroundImage: CachedNetworkImageProvider(provider.teamModel.members![index].image ?? ""),
                                ),
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (provider.teamModel.members!.isNotEmpty)
                      if (MediaQuery.sizeOf(context).width > 600)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: getImage(provider)),
                            const SizedBox(width: 30),
                            Expanded(flex: 2, child: getDetails(provider)),
                          ],
                        )
                      else
                        Column(children: [getImage(provider), const SizedBox(height: 30), getDetails(provider)]),

                    const SizedBox(height: 20),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Column getDetails(HomeProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(provider.teamModel.members![currentIndex].name ?? "", style: AppStyles.getSemiBoldTextStyle(fontSize: 24)),
        const SizedBox(height: 8),
        Text(provider.teamModel.members![currentIndex].desc ?? "", style: AppStyles.getRegularTextStyle(fontSize: 14)),
      ],
    );
  }

  AnimatedSwitcher getImage(HomeProvider provider) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: AspectRatio(
        key: ValueKey(currentIndex.toString()),
        aspectRatio: 3 / 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: CachedNetworkImage(imageUrl: provider.teamModel.members![currentIndex].image ?? "", fit: BoxFit.cover),
        ),
      ),
    );
  }
}
