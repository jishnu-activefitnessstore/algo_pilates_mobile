class PricingModel {
  String? title;
  String? description;
  List<Classes>? classes;

  PricingModel({this.title, this.description, this.classes});

  PricingModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  List<Pricing>? pricing;

  Classes({this.name, this.pricing});

  Classes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['pricing'] != null) {
      pricing = <Pricing>[];
      json['pricing'].forEach((v) {
        pricing!.add(Pricing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (pricing != null) {
      data['pricing'] = pricing!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pricing {
  String? name;
  double? price;
  String? timePeriod;
  List<String>? features;

  Pricing({this.name, this.price, this.timePeriod, this.features});

  Pricing.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    timePeriod = json['time_period'];
    features = json['features'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['time_period'] = timePeriod;
    data['features'] = features;
    return data;
  }
}
