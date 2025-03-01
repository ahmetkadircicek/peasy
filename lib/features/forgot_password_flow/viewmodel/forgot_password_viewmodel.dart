import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  int _step = 0;

  int get step => _step;

  void nextStep() {
    if (_step < 2) {
      _step++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_step > 0) {
      _step--;
      notifyListeners();
    }
  }

  void resetStep() {
    _step = 0;
    notifyListeners();
  }
}
