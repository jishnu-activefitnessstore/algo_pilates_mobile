import 'package:algo_pilates/src/features/classes/models/class_models.dart';
import 'package:flutter/material.dart';

class ClassProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ClassModel> _classes = [];
  List<ClassModel> get classes => _classes;

  String _classTitle = 'Our Classes';
  String get classTitle => _classTitle;

  String? _classDescription;
  String? get classDescription => _classDescription;

  putLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  getClasses() async {
    putLoading(true);
    _classes.clear();
    _classTitle = classJson['title']!.toString();
    _classDescription = classJson['description']?.toString();
    for (var element in classJson['classes'] as List) {
      _classes.add(ClassModel.fromJson(element as Map<String, dynamic>));
    }
    putLoading(false);
  }

  final classJson = {
    "title": "Our Classes",
    "description": null,
    "classes": [
      {
        "id": 1,
        "banner": "https://algopilates.com/assets/image/movement-principles.jpg",
        "title": "Movement Principles",
        "description":
            "From foundational control to high-performance training, each class is uniquely designed to elevate your Pilates experience. Whether you're just starting or advancing your practice, our signature formats help you build strength, balance, flexibility, and focus—one movement at a time.",
        "studio_location": {
          "image": "https://images.activefitnessstore.com/assets/stores/al_quos_sheikh_zayed_road_uae.jpg",
          "phone": "+971 54 581 6298",
          "address": "Mezzanine Floor, Junction Mall DIP, Dubai.",
          "map": "https://maps.app.goo.gl/shnPLvW85QWTXfX27",
        },
        "gallery": [
          "https://algopilates.com/assets/image/movement-principles.jpg",
          "https://algopilates.com/assets/image/movement-principles.jpg",
          "https://algopilates.com/assets/image/movement-principles.jpg",
          "https://algopilates.com/assets/image/movement-principles.jpg",
        ],
      },
      {
        "id": 2,
        "banner": "https://algopilates.com/assets/image/athletic-reformer.jpg",
        "title": "Athletic Reformer",
        "description":
            "From foundational control to high-performance training, each class is uniquely designed to elevate your Pilates experience. Whether you're just starting or advancing your practice, our signature formats help you build strength, balance, flexibility, and focus—one movement at a time.",
        "studio_location": {
          "image": "https://images.activefitnessstore.com/assets/stores/al_quos_sheikh_zayed_road_uae.jpg",
          "phone": "+971 54 581 6298",
          "address": "Mezzanine Floor, Junction Mall DIP, Dubai.",
          "map": "https://maps.app.goo.gl/shnPLvW85QWTXfX27",
        },
        "gallery": [
          "https://algopilates.com/assets/image/athletic-reformer.jpg",
          "https://algopilates.com/assets/image/athletic-reformer.jpg",
          "https://algopilates.com/assets/image/athletic-reformer.jpg",
          "https://algopilates.com/assets/image/athletic-reformer.jpg",
        ],
      },
      {
        "id": 3,
        "banner": "https://algopilates.com/assets/image/athletic-flow.jpg",
        "title": "Athletic Flow",
        "description":
            "From foundational control to high-performance training, each class is uniquely designed to elevate your Pilates experience. Whether you're just starting or advancing your practice, our signature formats help you build strength, balance, flexibility, and focus—one movement at a time.",
        "studio_location": {
          "image": "https://images.activefitnessstore.com/assets/stores/al_quos_sheikh_zayed_road_uae.jpg",
          "phone": "+971 54 581 6298",
          "address": "Mezzanine Floor, Junction Mall DIP, Dubai.",
          "map": "https://maps.app.goo.gl/shnPLvW85QWTXfX27",
        },
        "gallery": [
          "https://algopilates.com/assets/image/athletic-reformer.jpg",
          "https://algopilates.com/assets/image/athletic-reformer.jpg",
          "https://algopilates.com/assets/image/athletic-reformer.jpg",
          "https://algopilates.com/assets/image/athletic-reformer.jpg",
        ],
      },
    ],
  };
}
