import 'package:flutter/material.dart';

class GeneralConstants {
  static GeneralConstants? _instance;
  static GeneralConstants get instance {
    _instance ??= GeneralConstants._init();
    return _instance!;
  }

  GeneralConstants._init();

  final borderRadiusLarge = BorderRadius.circular(32);
  final borderRadiusMedium = BorderRadius.circular(16);
  final borderRadiusSmall = BorderRadius.circular(8);
}
