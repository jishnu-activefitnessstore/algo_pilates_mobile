class ClassModel {
  final int id;
  final String? banner;
  final String? title;
  final String? description;
  final List<String>? gallery;
  final StudioLocation? studioLocation;

  ClassModel({required this.id, this.banner, this.title, this.description, this.studioLocation, this.gallery});

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] as int,
      banner: json['banner'] as String,
      title: json['title'] as String,
      description: json['description'] as String,

      studioLocation: StudioLocation.fromJson(json['studio_location'] as Map<String, dynamic>),
      gallery: json['gallery'] as List<String>?,
    );
  }
}

class StudioLocation {
  final String image;
  final String phone;
  final String address;
  final String map;

  StudioLocation({required this.image, required this.phone, required this.address, required this.map});

  factory StudioLocation.fromJson(Map<String, dynamic> json) {
    return StudioLocation(
      image: json['image'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      map: json['map'] as String,
    );
  }
}
