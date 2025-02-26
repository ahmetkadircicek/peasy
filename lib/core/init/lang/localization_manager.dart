import 'package:flutter/material.dart';
import 'package:peasy/core/constants/enums/localization_enum.dart';

import 'localization_manager_interface.dart';

class LocalizationManager implements ILocalizationManager {
  static LocalizationManager? _instance;
  static LocalizationManager get instance {
    _instance ??= LocalizationManager._init();
    return _instance!;
  }

  LocalizationManager._init();

  @override
  String? localePath = 'assets/lang';

  final enUSLocale = const Locale('en', 'US');
  final trTRLocale = const Locale('tr', 'TR');
  final deDELocale = const Locale('de', 'DE');

  @override
  List<Locale> get supportedLocales => [enUSLocale, trTRLocale, deDELocale];

  @override
  LocalizationEnum currentLocale = LocalizationEnum.english;
}
