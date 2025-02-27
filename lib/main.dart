import 'package:flutter/material.dart';
import 'package:peasy/core/constants/navigation/navigation_service.dart';
import 'package:peasy/core/init/notifier/provider_manager.dart';
import 'package:peasy/core/init/theme/app_theme.dart';
import 'package:peasy/features/main/view/main_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // EasyLocalization.logger.enableBuildModes = [];

  runApp(
    MultiProvider(
      providers: [
        ...ProviderManager.instance.providers,
      ],
      // child: EasyLocalization(
      //   path: LocalizationManager.instance.localePath!,
      //   supportedLocales: LocalizationManager.instance.supportedLocales,
      //   startLocale: LocalizationEnum.english.translate,
      //   fallbackLocale: LocalizationManager.instance.enUSLocale,
      //   child: const MyApp(),
      // ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peasy',
      theme: LightTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const MainView(),
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
