import 'package:flutter/material.dart';
import 'package:ygo_companion/models/player.dart';
import 'package:ygo_companion/screens/calculator/widgets/calculator_pad_5.dart';

class TestLayout extends StatelessWidget {
  final Stopwatch mainWatch;
  final Stopwatch watchA;
  final Stopwatch watchB;
  final Duration mainWatchDuration;
  final Function onMainWatchTap;
  final Player playerA;
  final Player playerB;
  final Function(String) onInputTap;
  final Function(bool forPlayerA) onPlayerSelected;

  const TestLayout({
    Key key,
    this.mainWatch,
    this.playerA,
    this.playerB,
    this.watchA,
    this.watchB,
    this.mainWatchDuration,
    this.onInputTap,
    this.onPlayerSelected,
    this.onMainWatchTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("-----------> Test Layout build ");

    final screen = MediaQuery.of(context).size;

    print("screen.aspectRatio ${screen.aspectRatio}");
    print("screen height ${screen.shortestSide}");
    print("screen width ${screen.longestSide}");

    final calculatorHeight = screen.shortestSide * 8.5 / 10;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      body: Row(
        children: <Widget>[
          _buildCal(calculatorHeight),
          Column(
            children: <Widget>[
              Container(
                child: Text("8000"),
              )
            ],
          )
        ],
      ),
    );
  }

  Container _buildCal(double calHeight) {
    return Container(
      width: calHeight / 4 * 5 + 5,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: calHeight / 4 * 5 + 5,
              color: Colors.white,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "- 8000",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: calHeight,
            child: CalculatorPad(
              onKeyPress: (key) {},
            ),
          ),
        ],
      ),
    );
  }
}
