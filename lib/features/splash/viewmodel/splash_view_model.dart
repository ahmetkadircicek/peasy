import 'package:flutter/material.dart';
import 'package:peasy/core/init/navigation/navigation_service.dart';
import 'package:peasy/features/login/view/login_view.dart';

class SplashViewModel extends ChangeNotifier {
  bool isLoading = false;

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> init() async {
    changeLoading();
    await Future.delayed(const Duration(seconds: 2));
    NavigationService.instance.navigateTo(LoginView());
    changeLoading();
  }
}
