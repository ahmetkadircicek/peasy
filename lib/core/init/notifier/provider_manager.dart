import 'package:peasy/features/cart/viewmodel/cart_view_model.dart';
import 'package:peasy/features/category/viewmodel/category_view_model.dart';
import 'package:peasy/features/home/viewmodel/home_view_model.dart';
import 'package:peasy/features/navigation/viewmodel/navigation_view_model.dart';
import 'package:peasy/features/nfc/viewmodel/nfc_view_model.dart';
import 'package:peasy/features/receipts/viewmodel/receipt_view_model.dart';
import 'package:peasy/features/sales/viewmodel/sales_view_model.dart';
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
    ChangeNotifierProvider(create: (context) => NavigationViewModel()),
    ChangeNotifierProvider(create: (context) => CategoryViewModel()),
    ChangeNotifierProvider(create: (context) => CartViewModel()),
    ChangeNotifierProvider(create: (_) => NFCViewModel()),
    ChangeNotifierProvider(create: (context) => SalesViewModel()),
    ChangeNotifierProvider(create: (context) => ReceiptViewModel()),
  ];
}
