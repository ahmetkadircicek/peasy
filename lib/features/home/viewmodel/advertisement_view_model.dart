import 'dart:async';

import 'package:flutter/material.dart';

class AdvertisementViewModel extends ChangeNotifier {
  final _pageController = PageController();
  List<String> _imagePaths = [];
  int _currentIndex = 0;
  bool _isInitialized = false;
  bool _isLoaded = false;

  List<String> get imagePaths => _imagePaths;
  int get currentIndex => _currentIndex;
  PageController get pageController => _pageController;
  bool get isLoaded => _isLoaded;

  AdvertisementViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    if (_isInitialized) return;
    await fetchAdvertisements();
    _isInitialized = true;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> fetchAdvertisements() async {
    // Simulate a fake service call with a delay
    _isLoaded = false;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    _imagePaths = [
      'assets/images/01_advertisement.png',
      'assets/images/03_advertisement.png',
      'assets/images/02_advertisement.png',
    ];
    _isLoaded = true;
    notifyListeners();
  }

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
