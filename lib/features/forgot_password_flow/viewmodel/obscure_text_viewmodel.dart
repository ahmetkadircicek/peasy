import 'package:flutter/material.dart';

class ObscureTextProvider extends ChangeNotifier {
  bool _isObscured = true;

  bool get isObscured => _isObscured;

  void toggleVisibility() {
    _isObscured = !_isObscured;
    notifyListeners();
  }
}
