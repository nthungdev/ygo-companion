import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Perform calculator logic and control the state of Calculator Screen
class ThemeState with ChangeNotifier {
  static late BuildContext _context;

  static ThemeState of(BuildContext context, {bool listen = true}) {
    _context = context;
    return Provider.of<ThemeState>(context, listen: listen);
  }

  bool get isDarkMode => Theme.of(_context).brightness == Brightness.dark;

  ThemeMode _mode = ThemeMode.system;
  final SharedPreferences _prefs;

  ThemeMode get mode => _mode;

  ThemeState(this._prefs) {
    final isDark = _prefs.getBool("darkTheme");
    _mode = isDark == null
        ? ThemeMode.system
        : isDark
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  Future<void> switchMode(ThemeMode mode) async {
    if (mode == _mode) return;

    _mode = mode;
    notifyListeners();

    await _prefs.setBool(
      "darkTheme",
      mode == ThemeMode.dark || mode == ThemeMode.light,
    );
  }
}
