import 'package:algo_pilates/src/features/classes/models/class_models.dart';
import 'package:algo_pilates/src/features/classes/presentation/widgets/class_banner.dart';
import 'package:algo_pilates/src/features/classes/provider/class_provider.dart';
import 'package:algo_pilates/src/features/home/presentation/home_view.dart';
import 'package:algo_pilates/src/features/home/presentation/widget/custom_html_widget.dart';
import 'package:algo_pilates/src/features/home/presentation/widget/custom_scaffold.dart';
import 'package:algo_pilates/src/features/home/provider/home_provider.dart';
import 'package:algo_pilates/src/utilities/utilities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/class_container.dart';

class ClassDetailsView extends StatefulWidget {
  const ClassDetailsView({super.key, required this.id});
  static String route = 'class-details';
  final String id;
  @override
  State<ClassDetailsView> createState() => _ClassDetailsViewState();
}

class _ClassDetailsViewState extends State<ClassDetailsView> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final classModel = context.read<ClassProvider>().classModel.classes!.firstWhere(
      (e) => e.id.toString() == widget.id,
      orElse: () => Classes(id: 0),
    );
    final moreClassList = (context.watch<ClassProvider>().classModel.classes!).where((e) => e.id.toString() != widget.id).toList();
    return CustomScaffold(
      path: ClassDetailsView.route,
      scrollController: _scrollController,
      body:
          classModel.id == 0
              ? Center(child: Text("Class not found", style: AppStyles.getMediumTextStyle(fontSize: 16), textAlign: TextAlign.center))
              : ListView(
                controller: _scrollController,
                children: [
                  Container(
                    constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).width * 0.5, maxWidth: double.maxFinite),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(context.watch<HomeProvider>().homeModel.topBanner?.imageUrl ?? ""),
                        fit: BoxFit.cover,
                        alignment: Alignment(0, -0.5),
                      ),
                    ),
                    padding: kDefaultPadding,
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2,
                      child: Text(classModel.title ?? "", style: AppStyles.getMediumTextStyle(fontSize: 24, color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: kDefaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Class Information", style: AppStyles.getMediumTextStyle(fontSize: 21)),
                        const SizedBox(height: 16),
                        if (classModel.description != null) CustomHtmlWidget(htmlString: classModel.description!),
                        if (classModel.description != null) const SizedBox(height: 24),
                        ClassBanner(),
                        const SizedBox(height: 24),
                        Text("Studio Location", style: AppStyles.getMediumTextStyle(fontSize: 21)),
                        const SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(12),
                          height: 120,
                          decoration: BoxDecoration(color: AppColors.borderColor, borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            spacing: 16,
                            children: [
                              SizedBox(
                                child: AspectRatio(
                                  aspectRatio: 1.1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(imageUrl: classModel.studioLocation?.image ?? "", fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(classModel.studioLocation?.name ?? "", style: AppStyles.getRegularTextStyle(fontSize: 14)),
                                    Text(
                                      classModel.studioLocation?.address ?? "",
                                      style: AppStyles.getRegularTextStyle(fontSize: 12, color: Colors.black.withValues(alpha: 0.65)),
                                      maxLines: 2,
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () => launchUrl(Uri.parse(classModel.studioLocation!.map!)),
                                      child: Text(
                                        "View Map",
                                        style: AppStyles.getMediumTextStyle(fontSize: 12, color: AppColors.textLinkColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text("Gallery", style: AppStyles.getMediumTextStyle(fontSize: 21)),
                        const SizedBox(height: 16),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 4 / 3,
                          ),
                          itemCount: classModel.gallery?.length ?? 0,
                          itemBuilder:
                              (context, index) => ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(imageUrl: classModel.gallery![index], fit: BoxFit.cover),
                              ),
                        ),
                        const SizedBox(height: 30),
                        Text("More Classes", style: AppStyles.getMediumTextStyle(fontSize: 21)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.4,
                    child: ListView.separated(
                      padding: kDefaultHorizontalPadding,
                      itemCount: moreClassList.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder:
                          (context, index) => getImage(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.sizeOf(context).height * 0.4,
                              maxWidth: MediaQuery.sizeOf(context).width,
                            ),
                            classModel: moreClassList[index],
                            onTap:
                                () => context.pushNamed(
                                  ClassDetailsView.route,
                                  pathParameters: {'id': context.read<ClassProvider>().classModel.classes![index].id.toString()},
                                ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
    );
  }

  getImage({BoxConstraints? constraints, required Classes classModel, VoidCallback? onTap}) => SizedBox(
    height: (constraints!.maxHeight * 0.5),
    width: constraints.maxWidth * 0.625,
    child: ClassContainer(classModel: classModel, onTap: onTap),
  );
}
