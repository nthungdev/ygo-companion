import 'package:flutter/material.dart';

import 'package:ygo_companion/models/player.dart';
import 'package:ygo_companion/screens/calculator/widgets/calculator_pad_4.dart';
import 'package:ygo_companion/screens/calculator/widgets/duel_log_4.dart';
import 'package:ygo_companion/screens/calculator/widgets/main_watch_4.dart';
import 'package:ygo_companion/screens/calculator/widgets/player_lp_4.dart';
import 'package:ygo_companion/screens/calculator/widgets/player_watch_4.dart';

class ProLayout4 extends StatelessWidget {
  final Stopwatch mainWatch;
  final Stopwatch watchA;
  final Stopwatch watchB;
  final Duration mainWatchDuration;
  final Function onMainWatchTap;
  final Player playerA;
  final Player playerB;
  final Function(String) onInputTap;
  final Function(bool forPlayerA) onPlayerSelected;

  const ProLayout4({
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
  })  : assert(playerA != null),
        assert(playerB != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    print("----------------> ProLayout4 build");
    final screen = MediaQuery.of(context).removePadding(removeTop: true).size;
    final calculatorAspectRatio = 16 / 9;

    double vw;
    double vh;
    const double space = 5;

    print("screen.aspectRatio ${screen.aspectRatio}");
    print("calculatorAspectRatio $calculatorAspectRatio");

    print(MediaQuery.of(context).padding.top);

    if (screen.aspectRatio >= calculatorAspectRatio) {
      vh = screen.shortestSide - 2 * space;
      vw = vh * 16 / 9;
    } else {
      vw = screen.shortestSide - 2 * space;
      vh = vw * 9 / 16;
    }

    print("screen height ${screen.shortestSide}");
    print("screen width ${screen.longestSide}");
    print('vh: $vh');
    print('vw: $vw');

    print('content ratio: ${vw / vh}');

    double centerWidth = vw * 9 / 16 + space;
    double sideWidth = (vw - centerWidth - 2 * space) / 2;
    double bottomHeight = (centerWidth - space) * 4 / 5;
    double topHeight = vh - bottomHeight - space;

    print(sideWidth * 2 + space * 2 + centerWidth);

    print('centerWidth: $centerWidth');
    print('sideWidth: $sideWidth');
    print('topHeight: $topHeight');
    print('bottomHeight: $bottomHeight');
    print('topHeight + bottomHeight: ${topHeight + bottomHeight}');
    print('bottom width: ${2 * sideWidth + centerWidth + 2 * space}');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/calculator/background.png"),
            ),
          ),
          child: Center(
            child: _buildContent(
              space,
              topHeight,
              sideWidth,
              centerWidth,
              bottomHeight,
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildContent(
    double space,
    double topHeight,
    double sideWidth,
    double centerWidth,
    double bottomHeight,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: space, horizontal: space),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  PlayerWatch(
                    watch: this.playerA.watch,
                    width: sideWidth,
                  ),
                  SizedBox(width: space),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: PlayerLP(
                            lp: playerA.lp,
                            calculation: playerA.calculation,
                            onPressed: () => onPlayerSelected(true),
                          ),
                        ),
                        SizedBox(width: space),
                        Expanded(
                          flex: 6,
                          child: MainWatch(
                            watch: mainWatchDuration,
                            onTap: onMainWatchTap,
                          ),
                        ),
                        SizedBox(width: space),
                        Expanded(
                          flex: 3,
                          child: PlayerLP(
                            lp: playerB.lp,
                            calculation: playerB.calculation,
                            onPressed: () => onPlayerSelected(false),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: space),
                  PlayerWatch(
                    watch: playerB.watch,
                    width: sideWidth,
                  ),
                ],
              ),
            ),
            SizedBox(height: space),
            Container(
              height: bottomHeight,
              child: Row(
                children: <Widget>[
                  DuelLog(width: sideWidth),
                  SizedBox(width: space),
                  SizedBox(
                    width: centerWidth,
                    child: CalculatorPad(onKeyPress: onInputTap),
                  ),
                  SizedBox(width: space),
                  DuelLog(width: sideWidth, show: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
