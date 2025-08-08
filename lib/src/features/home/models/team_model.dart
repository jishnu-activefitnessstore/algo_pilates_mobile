import 'package:algo_pilates/src/utilities/utilities.dart';

class TeamModel {
  final String name;
  final String image;
  final String desc;

  TeamModel({required this.name, required this.image, required this.desc});

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(name: json['name'] ?? '', image: json['image'] ?? '', desc: json['desc'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'image': image, 'desc': desc};
  }
}

List<TeamModel> teams = [
  TeamModel(
    name: 'Anesti Mano',
    image: AppImages.anesti,
    desc:
        "Anesti Mano is an internationally renowned Pilates educator, NPCP-certified instructor, and natural bodybuilding athlete with a deep background in strength training and competitive men’s physique in Greece and Dubai.",
  ),
  TeamModel(
    name: 'Ruth Lim',
    image: AppImages.ruth,
    desc:
        "A proud mother of two. It takes a year of ‘scooping in’ ‘lengthening’ ‘conscious breathing’ ‘stabilize your pelvis’ to resolving my diastasis recti, mild scoliosis induced sore back, incontinence. A classical Pilates student, still is!!! Constantly diving deeper into the method and a Polestar certified instructor. Love the positive movement experience First, you control.. then you flow ..",
  ),
  TeamModel(
    name: 'Grace Rogers',
    image: AppImages.grace,
    desc:
        "Grace is a Polestar-trained Reformer Pilates instructor with a decade-long background in marketing, client relations, and strategic communication. Now fully immersed in the world of Pilates, she brings her professional experience and people-first mindset to the studio—creating a welcoming, empowering space for all bodies and fitness level",
  ),
  TeamModel(
    name: 'Yoojin Kim',
    image: AppImages.yoojin,
    desc:
        "Yoojin teaches Pilates with a contemporary approach, incorporating the mat, Reformer, Trapeze Table, Chair, and Ladder Barrel. She specializes in pain management and posture correction, tailoring each session to individual needs. Her focus is on helping clients develop body awareness in a motivating and supportive environment—ensuring they enjoy both the workout and the journey toward better movement and well-being.",
  ),
];
