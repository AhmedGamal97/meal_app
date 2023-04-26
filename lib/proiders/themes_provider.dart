import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderTheme with ChangeNotifier {
  var primaryColor = Colors.pink;
  var accentColor = Colors.amber;
  var tm = ThemeMode.system;
  String themeTxt = 's';
  onChanged(color, n) async {
    n == 1
        ? primaryColor = _toMaterialColor(color.hashCode)
        : accentColor = _toMaterialColor(color.hashCode);
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('primaryColor', primaryColor.value);
    prefs.setInt('accentColor', accentColor.value);
  }

  getThemeColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    primaryColor = _toMaterialColor(prefs.getInt('primaryColor') ?? 0xFFE91E63);
    accentColor = _toMaterialColor(prefs.getInt('accentColor') ?? 0XFFFFC107);
    notifyListeners();
  }

  MaterialColor _toMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: const Color(0xFFFFEBEE),
        100: const Color(0xFFFFCDD2),
        200: const Color(0xFFEF9A9A),
        300: const Color(0xFFE57373),
        400: const Color(0xFFEF5350),
        500: Color(colorVal),
        600: const Color(0xFFE53935),
        700: const Color(0xFFD32F2F),
        800: const Color(0xFFC62828),
        900: const Color(0xFFB71C1C),
      },
    );
  }

  void themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    _getThemeText(tm);

    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeTxt', themeTxt);
  }

  _getThemeText(ThemeMode tm) {
    if (tm == ThemeMode.dark) {
      themeTxt = 'd';
    } else if (tm == ThemeMode.light) {
      themeTxt = 'l';
    } else if (tm == ThemeMode.system) {
      themeTxt = 's';
    }
  }

  getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeTxt = prefs.getString('themeTxt') ?? 's';
    if (themeTxt == 'd') {
      tm = ThemeMode.dark;
    } else if (themeTxt == 'l') {
      tm = ThemeMode.light;
    } else if (themeTxt == 's') {
      tm = ThemeMode.system;
    }
    notifyListeners();
  }
}
