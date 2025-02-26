import 'package:flutter/material.dart';
import 'package:peasy/core/constants/enums/localization_enum.dart';

import '../init/lang/localization_manager.dart';

extension LocalizationExtension on LocalizationEnum {
  Locale? get translate {
    switch (this) {
      case LocalizationEnum.turkish:
        return LocalizationManager.instance.trTRLocale;
      case LocalizationEnum.english:
        return LocalizationManager.instance.enUSLocale;
      case LocalizationEnum.deutsch:
        return LocalizationManager.instance.deDELocale;
    }
  }
}
