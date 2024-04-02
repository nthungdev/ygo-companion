import 'package:flutter/material.dart';
import 'package:ygo_companion/routes.dart';
import 'package:ygo_companion/states/theme_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void handleGoToCalculator(context) {
    Navigator.of(context).pushNamed(Routes.calculator);
  }

  void handleGoToSetting(context) {
    Navigator.of(context).pushNamed(Routes.setting);
  }

  @override
  Widget build(BuildContext context) {
    // print("---------------> HomeScreen build");
    // print("height ${MediaQuery.of(context).size.height}");
    // print("width ${MediaQuery.of(context).size.width}");
    // print("width ${MediaQuery.of(context).padding}");
    // print("width ${MediaQuery.of(context).viewPadding}");

    // final withoutPadding =
    //     MediaQuery.of(context).removePadding(removeTop: true).size;
    // final withoutPadding =
    //     MediaQuery.of(context).removeViewPadding(removeTop: true).size;

    return Scaffold(
      body: Column(
        children: <Widget>[
          const Expanded(
            child: Center(
              child: Text(
                "YGO COMPANION",
                style: TextStyle(
                  fontFamily: "Helvetica Neue",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => handleGoToCalculator(context),
                  child: const Text("CALCULATOR"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ThemeState.of(context).isDarkMode
                        ? Colors.grey[200]
                        : Colors.grey[700],
                  ),
                  onPressed: () => handleGoToSetting(context),
                  // TODO
                  // textTheme: ButtonTextTheme.primary,
                  child: const Text("SETTINGS"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
