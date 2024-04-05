import 'dart:math';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:provider/provider.dart' show Provider;

class DiceState extends ChangeNotifier {
  static DiceState of(BuildContext context, {bool listen = true}) {
    return Provider.of<DiceState>(context, listen: listen);
  }

  final _randomizer = Random();
  int? _diceResult;

  int get diceResult => _diceResult ?? 6;

  void rollDice() async {
    List<int> allResults = [1, 2, 3, 4, 5, 6];

    for (int roll = 0; roll < 10; roll++) {
      List<int> possibleResults =
          allResults.where((roll) => roll != diceResult).toList();
      await Future.delayed(const Duration(milliseconds: 150));
      _diceResult = possibleResults[_randomizer.nextInt(5)];
      notifyListeners();
    }
  }
}
