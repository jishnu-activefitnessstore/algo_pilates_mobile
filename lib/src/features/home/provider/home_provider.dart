import 'package:algo_pilates/src/features/classes/provider/class_provider.dart';
import 'package:algo_pilates/src/features/home/models/contact_model.dart';
import 'package:algo_pilates/src/features/home/models/home_model.dart';
import 'package:algo_pilates/src/features/home/models/pricing_model.dart';
import 'package:algo_pilates/src/features/home/models/team_model.dart';
import 'package:algo_pilates/src/services/api_services.dart';
import 'package:algo_pilates/src/services/route_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  putLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  late HomeModel _homeModel;
  HomeModel get homeModel => _homeModel;

  late ContactModel _contactModel;
  ContactModel get contactModel => _contactModel;

  late PricingModel _pricingModel;
  PricingModel get pricingModel => _pricingModel;

  late TeamModel _teamModel;
  TeamModel get teamModel => _teamModel;

  final ApiServices _apiServices = ApiServices();

  getJsons() async {
    putLoading(true);
    List<Future> futures = [
      _apiServices.getJsonFromUrl("home"),
      _apiServices.getJsonFromUrl("contact"),
      _apiServices.getJsonFromUrl("pricing"),
      _apiServices.getJsonFromUrl("teams"),
      navigatorKey.currentContext!.read<ClassProvider>().getClasses(),
    ];
    final result = await Future.wait(futures);
    _homeModel = HomeModel.fromJson(result[0]);
    _contactModel = ContactModel.fromJson(result[1]);
    _pricingModel = PricingModel.fromJson(result[2]);
    _teamModel = TeamModel.fromJson(result[3]);

    putLoading(false);
  }
}
