import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
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
