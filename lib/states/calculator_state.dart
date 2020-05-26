import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import 'package:ygo_companion/models/player.dart';
import 'package:ygo_companion/utils/formatter.dart';

/// Perform calculator logic and control the state of Calculator Screen
class CalculatorState extends ChangeNotifier {
  static CalculatorState of(BuildContext context, {bool listen: true}) {
    return Provider.of<CalculatorState>(context, listen: listen);
  }

  CalculatorState() {
    playerA = Player(name: "A");
    playerB = Player(name: "B");
  }

  // PRIVATE VARIABLES //

  // GETTERS //
  Player playerA;
  Player playerB;

  // METHODS //

  void resetPlayerLP(bool forPlayerA) {
    final selectedPlayer = forPlayerA ? playerA : playerB;
    selectedPlayer.resetLp();
    selectedPlayer.clearLogs();

    notifyListeners();
  }

  /// If [forPlayerA] false, then it's for playerB
  ///
  /// Throw Exception if invalid expression
  void playerInput(bool forPlayerA, String input) {
    // TODO:
    List<String> validInputs = "1,2,3,4,5,6,7,8,9,0,00,=,x,C,(,),+,-,x2,÷2".split(",");

    // print('input $input');

    if (!validInputs.contains(input)) throw "Invalid input";

    Player selectedPlayer = forPlayerA ? playerA : playerB;

    switch (input) {
      case "x":
        if (selectedPlayer.calculation.isNotEmpty) {
          selectedPlayer.calculation =
              selectedPlayer.calculation.substring(0, selectedPlayer.calculation.length - 1);
        }
        break;
      case "C":
        selectedPlayer.calculation = "";
        break;
      case "=":
        Parser p = Parser();

        // TODO: Test and fix bug with symbol ( )

        try {
          final calculation = formatExpression(selectedPlayer.calculation);
          // print('calculation $calculation');
          Expression exp = p.parse(selectedPlayer.logs.last + calculation);
          final int evaluated = exp.evaluate(EvaluationType.REAL, ContextModel()).toInt();
          // print("evaluated $evaluated");
          selectedPlayer.logs.addAll([
            calculation.replaceAll("*", "x").replaceAll("/", "÷"),
            evaluated.toString(),
          ]);
          selectedPlayer.calculation = "";
          selectedPlayer.lp = evaluated;
        } catch (error) {
          throw Exception("Invalid expression");
        }
        break;
      default:
        selectedPlayer.calculation = selectedPlayer.calculation + input;
        break;
    }

    notifyListeners();
  }
}
