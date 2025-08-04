import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadThemePreference();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveThemePreference();
    notifyListeners();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    notifyListeners();
  }

  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      colorScheme:
          _isDarkMode
              ? const ColorScheme.dark(
                primary: Color(0xFF00B4D8), // Vibrant light blue
                secondary: Color(0xFF90E0EF), // Light blue
                tertiary: Color(0xFF48CAE4), // Medium blue
                surface: Color(0xFF0A1929), // Dark blue surface
                background: Color(0xFF001B3D), // Deep dark blue background
                onPrimary: Colors.white,
                onSecondary: Color(0xFF001B3D),
                onSurface: Colors.white,
                onBackground: Colors.white,
              )
              : const ColorScheme.light(
                primary: Color(0xFF00B4D8), // Vibrant light blue
                secondary: Color(0xFF90E0EF), // Light blue
                tertiary: Color(0xFF48CAE4), // Medium blue
                surface: Color(0xFFF8FAFC),
                background: Color(0xFFFFFFFF),
              ),
    );
  }
}
