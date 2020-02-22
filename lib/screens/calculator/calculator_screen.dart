import 'package:flutter/material.dart';
import 'package:ygo_companion/screens/calculator/layouts/pro_layout_2.dart';
import 'package:ygo_companion/screens/calculator/layouts/pro_layout_3.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return ProLayout2();
  }
}
