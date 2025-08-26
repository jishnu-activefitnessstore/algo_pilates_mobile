import 'package:algo_pilates/src/features/home/models/team_model.dart';
import 'package:algo_pilates/src/features/home/presentation/widget/custom_html_widget.dart';
import 'package:flutter/material.dart';

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
    final teams = teamJson['members']!.map<TeamModel>((e) => TeamModel.fromJson(e)).toList();
    return CustomScaffold(
      path: TeamsView.route,
      scrollController: _scrollController,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // SliverToBoxAdapter(child: TitleBox(title: "Our Team", subtitle: "Home > Our Team")),
          SliverPadding(
            padding: kDefaultPadding,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(teamJson['title'], style: AppStyles.getSemiBoldTextStyle(fontSize: 32)),
                const SizedBox(height: 24),
                CustomHtmlWidget(htmlString: teamJson['description']),
                const SizedBox(height: 30),
                SizedBox(
                  height: 100,
                  child: Center(
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: teams.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 8),
                      itemBuilder:
                          (context, index) => InkWell(
                            onTap: () {
                              setState(() => currentIndex = index);
                            },
                            child: CircleAvatar(radius: currentIndex == index ? 50 : 40, foregroundImage: AssetImage(teams[index].image)),
                          ),
                    ),
                  ),
                ),
                // const SizedBox(height: 30),
                if (teams.isNotEmpty)
                  AspectRatio(
                    aspectRatio: 3 / 4,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),

                      child: ClipRRect(
                        key: ValueKey(currentIndex.toString()),
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(teams[currentIndex].image, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                // const SizedBox(height: 30),
                Text(teams[currentIndex].name, style: AppStyles.getSemiBoldTextStyle(fontSize: 28)),
                const SizedBox(height: 8),
                Text(teams[currentIndex].desc, style: AppStyles.getRegularTextStyle(fontSize: 16)),

                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  final Map<String, dynamic> teamJson = {
    "title": "Meet Our Team",
    "description":
        "<p>We have united the world’s most engaging and highly-skilled Reformer Pilates trainers, committed to helping you find your greatness. Each has been hand-picked for their unique flair and passion. Let them be your guides on this Reformer Pilates journey, with our Reformer Pilates studios becoming your destination for change.</p>",
    "members": [
      {
        "name": "Anesti Mano",
        "image": "assets/images/anesti.jpg",
        "desc":
            "Anesti Mano is an internationally renowned Pilates educator, NPCP-certified instructor, and natural bodybuilding athlete with a deep background in strength training and competitive men’s physique in Greece and Dubai.",
      },
      {
        "name": "Ruth Lim",
        "image": "assets/images/ruth-lim.jpg",
        "desc":
            "A proud mother of two. It takes a year of ‘scooping in’ ‘lengthening’ ‘conscious breathing’ ‘stabilize your pelvis’ to resolving my diastasis recti, mild scoliosis induced sore back, incontinence. A classical Pilates student, still is!!! Constantly diving deeper into the method and a Polestar certified instructor. Love the positive movement experience First, you control.. then you flow ..",
      },
      {
        "name": "Grace Rogers",
        "image": "assets/images/grace.jpg",
        "desc":
            "Grace is a Polestar-trained Reformer Pilates instructor with a decade-long background in marketing, client relations, and strategic communication. Now fully immersed in the world of Pilates, she brings her professional experience and people-first mindset to the studio—creating a welcoming, empowering space for all bodies and fitness level",
      },
      {
        "name": "Yoojin Kim",
        "image": "assets/images/yoojin.jpg",
        "desc":
            "Yoojin teaches Pilates with a contemporary approach, incorporating the mat, Reformer, Trapeze Table, Chair, and Ladder Barrel. She specializes in pain management and posture correction, tailoring each session to individual needs. Her focus is on helping clients develop body awareness in a motivating and supportive environment—ensuring they enjoy both the workout and the journey toward better movement and well-being.",
      },
    ],
  };
}
