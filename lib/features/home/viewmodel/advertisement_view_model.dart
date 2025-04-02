import 'package:flutter/material.dart';
import 'dart:async';

class AdvertisementViewModel extends ChangeNotifier {
  final _pageController = PageController();
  List<String> _imagePaths = [];
  int _currentIndex = 0;
  bool _isInitialized = false;
  Timer? _autoChangeTimer;

  List<String> get imagePaths => _imagePaths;
  int get currentIndex => _currentIndex;
  PageController get pageController => _pageController;

  AdvertisementViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    if (_isInitialized) return;
    await fetchAdvertisements();
    _isInitialized = true;
  }

  void _startAutoChange() {
    _autoChangeTimer?.cancel();
    _autoChangeTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_imagePaths.isNotEmpty) {
        _currentIndex = (_currentIndex + 1) % _imagePaths.length;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _autoChangeTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> fetchAdvertisements() async {
    _imagePaths = [
      'assets/images/01_advertisement.png',
      'assets/images/03_advertisement.png',
      'assets/images/02_advertisement.png',
    ];
    notifyListeners();
    _startAutoChange();
  }

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
