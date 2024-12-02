import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'lightmode_theme.dart';
import 'darkmode_theme.dart';
import 'bluemode_theme.dart';// Asegúrate de importar los temas

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  ThemeData get themeData => _themeData;

  void setTheme(ThemeData theme) async {
    _themeData = theme;
    notifyListeners();
    await _saveThemeToPrefs(theme);
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('theme') ?? 'light';
    switch (themeName) {
      case 'dark':
        _themeData = darkMode;
        break;
      case 'blue':
        _themeData = blueMode;
        break;
      default:
        _themeData = lightMode;
    }
    notifyListeners();
  }

  Future<void> _saveThemeToPrefs(ThemeData theme) async {
    final prefs = await SharedPreferences.getInstance();
    String themeName;
    if (theme == darkMode) {
      themeName = 'dark';
    } else if (theme == blueMode) {
      themeName = 'blue';
    } else {
      themeName = 'light';
    }
    await prefs.setString('theme', themeName);
  }
}
