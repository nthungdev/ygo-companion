import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ygo_companion/screens/setting/setting_screen.dart';
import 'package:ygo_companion/states/calculator_state.dart';
import 'package:ygo_companion/screens/calculator/calculator_screen.dart';
import 'package:ygo_companion/screens/home/home_screen.dart';
import 'package:ygo_companion/states/coin_state.dart';
import 'package:ygo_companion/states/dice_state.dart';

typedef WidgetBuilder = Widget Function(BuildContext context);

class Routes {
  /// Returns Map of routes for MaterialApp
  static Map<String, WidgetBuilder> routes(BuildContext context) {
    return {
      home: (_) => HomeScreen(),
      calculator: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => CalculatorState()),
              ChangeNotifierProvider(create: (_) => DiceState()),
              ChangeNotifierProvider(create: (_) => CoinState()),
            ],
            child: CalculatorScreen(),
          ),
      setting: (_) => SettingScreen(),
    };
  }

  static String home = '/home';
  static String calculator = '/calculator';
  static String setting = '/setting';
}
