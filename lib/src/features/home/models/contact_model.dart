class ContactModel {
  String? title;
  String? description;
  String? phone;
  String? email;
  String? address;
  Whatsapp? whatsapp;
  double? lat;
  double? long;
  String? mapUrl;
  String? mapImage;

  ContactModel({this.title, this.description, this.phone, this.email, this.address, this.whatsapp});

  ContactModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    whatsapp = json['whatsapp'] != null ? Whatsapp.fromJson(json['whatsapp']) : null;
    lat = json['latitude'];
    long = json['longitude'];
    mapUrl = json['map_url'];
    mapImage = json['map_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    if (whatsapp != null) {
      data['whatsapp'] = whatsapp!.toJson();
    }
    data['latitude'] = lat;
    data['longitude'] = long;

    return data;
  }
}

class Whatsapp {
  String? title;
  String? description;
  String? buttonTitle;
  String? whatsappNo;

  Whatsapp({this.title, this.description, this.buttonTitle, this.whatsappNo});

  Whatsapp.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    buttonTitle = json['button_title'];
    whatsappNo = json['whatsapp_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['button_title'] = buttonTitle;
    data['whatsapp_no'] = whatsappNo;
    return data;
  }
}
