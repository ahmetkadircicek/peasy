import 'package:peasy/features/home/viewmodel/home_view_model.dart';
import 'package:peasy/features/main/viewmodel/main_view_model.dart';
import 'package:peasy/features/splash/viewmodel/splash_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderManager {
  static ProviderManager? _instance;
  static ProviderManager get instance {
    _instance ??= ProviderManager._init();
    return _instance!;
  }

  ProviderManager._init();

  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => SplashViewModel()),
    ChangeNotifierProvider(create: (context) => HomeViewModel()),
    ChangeNotifierProvider(create: (context) => MainViewModel()),
  ];
}
