import 'package:flutter/material.dart';
import 'package:peasy/core/constants/enums/localization_enum.dart';

abstract class ILocalizationManager {
  String? localePath;
  List<Locale> get supportedLocales;
  LocalizationEnum currentLocale = LocalizationEnum.english;
}
