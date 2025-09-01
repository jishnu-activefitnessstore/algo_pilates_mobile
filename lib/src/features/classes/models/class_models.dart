class ClassModel {
  String? title;
  String? description;
  List<Classes>? classes;

  ClassModel({this.title, this.description, this.classes});

  ClassModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    if (json['classes'] != null) {
      classes = <Classes>[];
      json['classes'].forEach((v) {
        classes!.add(Classes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    if (classes != null) {
      data['classes'] = classes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Classes {
  int? id;
  String? banner;
  String? title;
  String? description;
  StudioLocation? studioLocation;
  List<String>? gallery;

  Classes({this.id, this.banner, this.title, this.description, this.studioLocation, this.gallery});

  Classes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    title = json['title'];
    description = json['description'];
    studioLocation = json['studio_location'] != null ? StudioLocation.fromJson(json['studio_location']) : null;
    gallery = json['gallery'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['banner'] = banner;
    data['title'] = title;
    data['description'] = description;
    if (studioLocation != null) {
      data['studio_location'] = studioLocation!.toJson();
    }
    data['gallery'] = gallery;
    return data;
  }
}

class StudioLocation {
  String? name;
  String? image;
  String? phone;
  String? address;
  String? map;

  StudioLocation({this.name, this.image, this.phone, this.address, this.map});

  StudioLocation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    address = json['address'];
    map = json['map'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['phone'] = phone;
    data['address'] = address;
    data['map'] = map;
    return data;
  }
}
