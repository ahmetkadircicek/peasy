import 'package:flutter/material.dart';
import 'package:peasy/core/init/lang/localization_manager.dart';

class SplashViewModel extends ChangeNotifier {
  static SplashViewModel? _instance;
  static SplashViewModel get instance {
    _instance ??= SplashViewModel._init();
    return _instance!;
  }

  SplashViewModel._init();

  final LocalizationManager localizationManager = LocalizationManager.instance;

  bool isLoading = false;

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> init() async {
    changeLoading();
    await Future.delayed(const Duration(seconds: 2));
    changeLoading();
  }
}
