import 'package:flutter/material.dart';

class MainViewModel with ChangeNotifier {
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
