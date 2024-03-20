import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  late bool _isLightTheme;
  ThemeNotifier() {
    _isLightTheme = true;
  }

  set lightTheme(bool light) {
    _isLightTheme = light;
    notifyListeners();
  }

  bool get isLightTheme => _isLightTheme;
}
