import 'package:flutter/material.dart';

class MainViewModel with ChangeNotifier {
  // Static key that can be accessed from anywhere to control the drawer
  static GlobalKey<ScaffoldState>? _scaffoldKey;

  static void setScaffoldKey(GlobalKey<ScaffoldState> key) {
    _scaffoldKey = key;
  }

  static void openDrawer() {
    _scaffoldKey?.currentState?.openDrawer();
  }

  final PageController pageController = PageController();
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  void onPageChanged(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
