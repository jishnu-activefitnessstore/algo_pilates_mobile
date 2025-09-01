import 'package:algo_pilates/src/features/classes/presentation/class_details_view.dart';
import 'package:algo_pilates/src/features/classes/presentation/widgets/class_container.dart';
import 'package:algo_pilates/src/features/classes/provider/class_provider.dart';
import 'package:algo_pilates/src/features/home/presentation/widget/custom_scaffold.dart';
import 'package:algo_pilates/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../home/presentation/widget/custom_html_widget.dart';
import 'widgets/class_banner.dart';

class ClassListitngView extends StatefulWidget {
  const ClassListitngView({super.key});
  static const String route = 'class-listing';
  @override
  State<ClassListitngView> createState() => _ClassListitngViewState();
}

class _ClassListitngViewState extends State<ClassListitngView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      path: ClassListitngView.route,
      scrollController: _scrollController,
      body: Consumer<ClassProvider>(
        builder: (context, provider, _) {
          return ListView(
            controller: _scrollController,
            padding: kDefaultPadding,
            children: [
              ClassBanner(),
              const SizedBox(height: 24),
              Text(provider.classModel.title ?? "", style: AppStyles.getMediumTextStyle(fontSize: 25)),
              const SizedBox(height: 16),
              if (provider.classModel.description != null) CustomHtmlWidget(htmlString: provider.classModel.description!),
              if (provider.classModel.description != null) const SizedBox(height: 16),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.classModel.classes!.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder:
                    (context, index) => AspectRatio(
                      aspectRatio: 3 / 4,
                      child: ClassContainer(
                        classModel: provider.classModel.classes![index],
                        padding: 16,
                        onTap:
                            () => context.pushNamed(
                              ClassDetailsView.route,
                              pathParameters: {'id': provider.classModel.classes![index].id.toString()},
                            ),
                      ),
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// "url":
//     "https://api.whatsapp.com/send/?phone=${ApiServices.whatsapp}&text=Hi%2C+I+need+this+course+details&type=phone_number&app_absent=0",
