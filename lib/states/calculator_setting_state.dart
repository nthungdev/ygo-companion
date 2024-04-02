import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculatorSettingState extends ChangeNotifier {
  static CalculatorSettingState of(BuildContext context, {bool listen = true}) {
    return Provider.of<CalculatorSettingState>(context, listen: listen);
  }

  final _kSPLayoutKey = "CalculatorLayout";
  CalculatorLayout? _layout;
  SharedPreferences _prefs;

  CalculatorLayout? get calculatorLayout => _layout;

  CalculatorSettingState(this._prefs);

  // METHODS //

  void init() {
    // TODO consider make layout a constructor param and move this to the constructor caller
    // Get CalculatorLayout
    final spLayout = _prefs.getString(_kSPLayoutKey);
    _layout = CalculatorLayout.values.firstWhere(
      (layout) => layout.toString() == spLayout,
      orElse: () => CalculatorLayout.HN_AV_1,
    );
  }

  Future<void> changeLayout(CalculatorLayout layout) async {
    _layout = layout;
    notifyListeners();
    await _prefs.setString(_kSPLayoutKey, layout.toString());
  }

  String getName(CalculatorLayout? layout) {
    switch (layout) {
      case CalculatorLayout.HN_AV_1:
        return "Advance 1";
      case CalculatorLayout.AT_AV_1:
        return "Advance 2";
      default:
        return "Basic";
    }
  }
}

enum CalculatorLayout {
  HN_AV_1,
  AT_AV_1,
}
