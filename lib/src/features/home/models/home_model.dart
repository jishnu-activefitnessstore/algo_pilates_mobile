class HomeModel {
  Version? version;
  TopBanner? topBanner;
  String? description;
  String? descImage;
  String? highlights;
  bool? showClasses;
  String? classesTitle;

  HomeModel({this.version, this.topBanner, this.description, this.descImage, this.highlights, this.showClasses, this.classesTitle});

  HomeModel.fromJson(Map<String, dynamic> json) {
    version = json['version'] != null ? Version.fromJson(json['version']) : null;
    topBanner = json['top_banner'] != null ? TopBanner.fromJson(json['top_banner']) : null;
    description = json['description'];
    descImage = json['descImage'];
    highlights = json['highlights'];
    showClasses = json['show_classes'];
    classesTitle = json['classes_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (version != null) {
      data['version'] = version!.toJson();
    }
    if (topBanner != null) {
      data['top_banner'] = topBanner!.toJson();
    }
    data['description'] = description;
    data['descImage'] = descImage;
    data['highlights'] = highlights;
    data['show_classes'] = showClasses;
    data['classes_title'] = classesTitle;
    return data;
  }
}

class Version {
  String? androidVersion;
  String? iosVersion;
  bool? isAndroidUpdateMandatory;
  bool? isIosUpdateMandatory;

  Version({this.androidVersion, this.iosVersion, this.isAndroidUpdateMandatory, this.isIosUpdateMandatory});

  Version.fromJson(Map<String, dynamic> json) {
    androidVersion = json['android_version'];
    iosVersion = json['ios_version'];
    isAndroidUpdateMandatory = json['isAndroidUpdateMandatory'];
    isIosUpdateMandatory = json['isIosUpdateMandatory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['android_version'] = androidVersion;
    data['ios_version'] = iosVersion;
    data['isAndroidUpdateMandatory'] = isAndroidUpdateMandatory;
    data['isIosUpdateMandatory'] = isIosUpdateMandatory;
    return data;
  }
}

class TopBanner {
  String? imageUrl;
  String? title;
  bool? showBookNow;

  TopBanner({this.imageUrl, this.title, this.showBookNow});

  TopBanner.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    title = json['title'];
    showBookNow = json['showBookNow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['title'] = title;
    data['showBookNow'] = showBookNow;
    return data;
  }
}
