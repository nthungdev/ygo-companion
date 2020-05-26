import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ygo_companion/states/dice_state.dart';
import 'package:ygo_companion/states/theme_state.dart';
import 'package:ygo_companion/widgets/icons/dice_icons.dart';

class DiceResult extends StatefulWidget {
  DiceResult({
    Key key,
    this.value,
    this.onClose,
  }) : super(key: key);

  final int value;
  final VoidCallback onClose;

  @override
  _DiceResultState createState() => _DiceResultState();
}

class _DiceResultState extends State<DiceResult> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClose,
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Colors.black.withAlpha(200),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: ThemeState.of(context).isDarkMode ? Colors.grey : Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Selector<DiceState, int>(
              selector: (_, state) => state.diceResult,
              builder: (_, diceResult, __) {
                final icon = diceResult == 1
                    ? DiceIcons.dice1
                    : diceResult == 2
                        ? DiceIcons.dice2
                        : diceResult == 3
                            ? DiceIcons.dice3
                            : diceResult == 4
                                ? DiceIcons.dice4
                                : diceResult == 5 ? DiceIcons.dice5 : DiceIcons.dice6;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.shortestSide * 0.3,
                          height: MediaQuery.of(context).size.shortestSide * 0.3,
                        ),
                        Icon(
                          icon,
                          color: Theme.of(context).primaryColor,
                          size: MediaQuery.of(context).size.shortestSide * 0.4,
                        ),
                      ],
                    ),
                    Text(diceResult.toString()),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
