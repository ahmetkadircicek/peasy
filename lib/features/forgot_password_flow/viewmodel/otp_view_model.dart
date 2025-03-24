import 'package:flutter/material.dart';

class OtpViewModel extends ChangeNotifier {
  final List<TextEditingController> _controllers =
      List.generate(5, (index) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());

  List<TextEditingController> get controllers => _controllers;
  List<FocusNode> get focusNodes => _focusNodes;

  void onOtpChanged(int index, String value, BuildContext context) {
    if (value.isNotEmpty) {
      if (index < 5) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
