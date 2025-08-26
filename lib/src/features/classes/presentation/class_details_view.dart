import 'package:algo_pilates/src/features/home/presentation/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';

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
    return CustomScaffold(
      path: ClassDetailsView.route,
      scrollController: _scrollController,
      body: ListView(controller: _scrollController, children: []),
    );
  }
}
