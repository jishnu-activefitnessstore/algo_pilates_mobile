class TeamModel {
  String? title;
  String? description;
  List<Members>? members;

  TeamModel({this.title, this.description, this.members});

  TeamModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  String? name;
  String? image;
  String? desc;

  Members({this.name, this.image, this.desc});

  Members.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['desc'] = desc;
    return data;
  }
}
