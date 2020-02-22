import 'package:flutter/material.dart';
import 'package:ygo_companion/screens/calculator/calculator_screen.dart';
import 'package:ygo_companion/screens/home/home_screen.dart';
import 'package:ygo_companion/theme.dart';

/// The root of YGO Companion app
class CompanionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YGO Companion',
      theme: CompanionTheme.of(context),
      routes: {
        "/": (_) => HomeScreen(),
        "/calculator": (_) => CalculatorScreen(),
      },
      initialRoute: "/",
    );
  }
}
