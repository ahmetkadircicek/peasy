import 'package:flutter/material.dart';

class GeneralConstants {
  static GeneralConstants? _instance;
  static GeneralConstants get instance {
    _instance ??= GeneralConstants._init();
    return _instance!;
  }

  GeneralConstants._init();

  final heightExtraLarge = 100.0; // 100.0
  final heightLarge = 80.0; // 80.0
  final heightMedium = 60.0; // 60.0
  final heightSmall = 40.0; // 40.0
  final heightExtraSmall = 20.0; // 20.0

  final borderRadius = BorderRadius.circular(8); // 8
  final radius = const Radius.circular(32);
  final outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(32),
  );

  final fontSizeExtraSmall = 10.0; // 12.0
  final fontSizeSmall = 12.0; // 16.0
  final fontSizeMedium = 14.0; // 20.0
  final fontSizeLarge = 18.0; // 24.0
  final fontSizeExtraLarge = 24.0; // 28.0

  final fontWeightLight = FontWeight.w300; // w300
  final fontWeightRegular = FontWeight.w500; // w500
  final fontWeightBold = FontWeight.w700; // w700
}
