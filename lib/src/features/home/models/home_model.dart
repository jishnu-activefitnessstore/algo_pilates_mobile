class HomeModel {
  Version? version;
  TopBanner? topBanner;
  String? description;
  String? descImage;
  String? highlights;
  bool? showClasses;
  String? classesTitle;
  String? bookingUrl;
  SplashData? splashData;
  YoutubeData? youtubeUrl;

  HomeModel({this.version, this.topBanner, this.description, this.descImage, this.highlights, this.showClasses, this.classesTitle});

  HomeModel.fromJson(Map<String, dynamic> json) {
    version = json['version'] != null ? Version.fromJson(json['version']) : null;
    topBanner = json['top_banner'] != null ? TopBanner.fromJson(json['top_banner']) : null;
    description = json['description'];
    descImage = json['descImage'];
    highlights = json['highlights'];
    showClasses = json['show_classes'];
    classesTitle = json['classes_title'];
    bookingUrl = json['booking_url'];
    splashData = json['splash_data'] != null ? SplashData.fromJson(json['splash_data']) : null;
    youtubeUrl = json['youtube'] != null ? YoutubeData.fromJson(json['youtube']) : null;
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
  String? androidLink;
  String? iosLink;

  Version({this.androidVersion, this.iosVersion, this.isAndroidUpdateMandatory, this.isIosUpdateMandatory});

  Version.fromJson(Map<String, dynamic> json) {
    androidVersion = json['android_version'];
    iosVersion = json['ios_version'];
    isAndroidUpdateMandatory = json['isAndroidUpdateMandatory'];
    isIosUpdateMandatory = json['isIosUpdateMandatory'];
    androidLink = json['android_link'];
    iosLink = json['ios_link'];
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

class SplashData {
  String? mediaUrl;
  String? type;
  bool? isMuted;

  SplashData({this.mediaUrl, this.type, this.isMuted = true});
  SplashData.fromJson(Map<String, dynamic> json) {
    mediaUrl = json['media_url'];
    type = json['media_type'];
    isMuted = json['is_muted'] == true;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media_url'] = mediaUrl;
    data['media_type'] = type;
    data['is_muted'] = isMuted;
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

class YoutubeData {
  String? title;
  String? mediaUrl;
  String? thumbnailUrl;

  YoutubeData({this.mediaUrl, this.thumbnailUrl});
  YoutubeData.fromJson(Map<String, dynamic> json) {
    mediaUrl = json['media_url'];
    thumbnailUrl = json['thumbnail_url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media_url'] = mediaUrl;
    data['thumbnail_url'] = thumbnailUrl;
    data['title'] = title;
    return data;
  }
}
