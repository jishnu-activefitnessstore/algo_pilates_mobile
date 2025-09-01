import 'package:algo_pilates/src/features/classes/models/class_models.dart';
import 'package:algo_pilates/src/services/api_services.dart';
import 'package:flutter/material.dart';

class ClassProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late ClassModel _classModel;
  ClassModel get classModel => _classModel;

  putLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  getClasses() async {
    putLoading(true);
    var data = await ApiServices().getJsonFromUrl("classes");
    _classModel = ClassModel.fromJson(data);
    putLoading(false);
  }
}
