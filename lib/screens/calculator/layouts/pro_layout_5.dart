import 'package:flutter/material.dart';

import 'package:ygo_companion/models/player.dart';
import 'package:ygo_companion/screens/calculator/widgets/calculator_pad_5.dart';
import 'package:ygo_companion/screens/calculator/widgets/duel_log_5.dart';
import 'package:ygo_companion/screens/calculator/widgets/icon_buttons_row_5.dart';
import 'package:ygo_companion/screens/calculator/widgets/main_clock_5.dart';
import 'package:ygo_companion/screens/calculator/widgets/player_lp_5.dart';
import 'package:ygo_companion/screens/calculator/widgets/player_clock_5.dart';
import 'package:ygo_companion/states/theme_state.dart';
import 'package:ygo_companion/widgets/coin_result.dart';
import 'package:ygo_companion/widgets/dice_result.dart';

class ProLayout5 extends StatelessWidget {
  final Duration mainClockDuration;
  final Duration clockADuration;
  final Duration clockBDuration;
  final Player playerA;
  final Player playerB;
  final bool isPlaying;
  final bool isUsingCoin;
  final bool isUsingDice;
  final bool playerASelected;
  final void Function(String) onInputTap;
  final void Function(bool forPlayerA) onPlayerFocused;
  final VoidCallback onCloseCoin;
  final VoidCallback onCloseDice;
  final VoidCallback onPlayerATap;
  final VoidCallback onPlayerBTap;
  final VoidCallback onPlayerALongPress;
  final VoidCallback onPlayerBLongPress;
  final VoidCallback? onPlayerALPTap;
  final VoidCallback? onPlayerBLPTap;
  final VoidCallback onMainClockTap;
  final VoidCallback onMainClockLongPressed;
  final VoidCallback onPlayerAClockTap;
  final VoidCallback onPlayerBClockTap;
  final VoidCallback onPlayerAClockLongPressed;
  final VoidCallback onPlayerBClockLongPressed;
  final VoidCallback onCoin;
  final VoidCallback onDice;
  final VoidCallback onReset;
  final VoidCallback onPlayPause;

  const ProLayout5({
    super.key,
    this.isPlaying = false,
    this.isUsingCoin = false,
    this.isUsingDice = false,
    required this.onPlayerFocused,
    required this.mainClockDuration,
    required this.clockADuration,
    required this.clockBDuration,
    required this.onPlayerAClockTap,
    required this.onPlayerBClockTap,
    this.onPlayerALPTap,
    this.onPlayerBLPTap,
    required this.onPlayerALongPress,
    required this.onPlayerBLongPress,
    required this.playerA,
    required this.playerB,
    required this.onPlayerAClockLongPressed,
    required this.onPlayerBClockLongPressed,
    required this.onInputTap,
    required this.onMainClockTap,
    required this.onPlayerATap,
    required this.onPlayerBTap,
    required this.playerASelected,
    required this.onCoin,
    required this.onDice,
    required this.onReset,
    required this.onPlayPause,
    required this.onCloseCoin,
    required this.onCloseDice,
    required this.onMainClockLongPressed,
  });

  static const double space = 5.0;
  static const double layoutAspectRatio = 16 / 9;
  static const double iconBoxHeight = 50.0;
  static final boxBackgroundColor = Colors.white.withAlpha(200);
  static final selectedColor = Colors.amber.withAlpha(200);

  /// Top row contains (from left to right):
  /// Player A LP
  /// Player A clock
  /// Main clock
  /// Player B clock
  /// Player B LP
  Widget _buildTopRow({required double height}) {
    return Container(
      height: height,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: PlayerLP(
              label: "Player A LP",
              lp: playerA.lp,
              // calculation: playerA.calculation,
              onPressed: onPlayerATap,
              onLongPress: onPlayerALongPress,
              selected: playerASelected,
            ),
          ),
          const SizedBox(width: space),
          Expanded(
            flex: 1,
            child: PlayerClock(
              label: "Player A Clock",
              // clock: clockADuration,
              // color: boxBackgroundColor,
              onTap: onPlayerAClockTap,
              onLongPressed: onPlayerAClockLongPressed,
              forPlayerA: true,
            ),
          ),
          const SizedBox(width: space),
          Expanded(
            flex: 2,
            child: MainClock(
              clock: mainClockDuration,
              onTap: onMainClockTap,
              // color: boxBackgroundColor,
            ),
          ),
          const SizedBox(width: space),
          Expanded(
            flex: 1,
            child: PlayerClock(
              label: "Player B Clock",
              // clock: clockBDuration,
              // color: boxBackgroundColor,
              onTap: onPlayerBClockTap,
              onLongPressed: onPlayerBClockLongPressed,
              forPlayerA: false,
            ),
          ),
          const SizedBox(width: space),
          Expanded(
            flex: 1,
            child: PlayerLP(
              label: "Player B LP",
              lp: playerB.lp,
              selected: !playerASelected,
              onLongPress: onPlayerBLongPress,
              // calculation: playerB.calculation,
              onPressed: onPlayerBTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomRow() {
    return Expanded(
      child: LayoutBuilder(builder: (context, boxConstraint) {
        final bottomRowHeight = boxConstraint.maxHeight;
        final calculatorPadHeight = bottomRowHeight - iconBoxHeight - space;
        final iconBoxWidth = (calculatorPadHeight / 4) * 5 + space;

        return Row(
          children: <Widget>[
            // Player A Duel Log
            Expanded(
              child: DuelLog(
                logs: playerA.logs,
                calculation: playerA.calculation,
                selected: playerASelected,
              ),
            ),
            const SizedBox(width: space),
            // Icon Buttons and Calculator Pad
            Column(
              children: <Widget>[
                IconButtonsRow(
                  height: iconBoxHeight,
                  width: iconBoxWidth,
                  isPlaying: isPlaying,
                  onCoin: onCoin,
                  onDice: onDice,
                  onReset: onReset,
                  onPlayPause: onPlayPause,
                ),
                const SizedBox(height: space),
                Expanded(
                  child: CalculatorPad(
                    onKeyPress: onInputTap,
                    space: space,
                  ),
                ),
              ],
            ),
            const SizedBox(width: space),
            // Player B Duel Log
            Expanded(
              child: DuelLog(
                logs: playerB.logs,
                calculation: playerB.calculation,
                selected: !playerASelected,
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ThemeState.of(context, listen: false).isDarkMode
            ? null
            : const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/calculator/background.png"),
                ),
              ),
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Center(
                child: AspectRatio(
                  aspectRatio: layoutAspectRatio,
                  child: Container(
                    padding: EdgeInsets.all(space),
                    child: LayoutBuilder(
                      builder: (context, boxConstraint) {
                        final topRowHeight = boxConstraint.maxHeight / 5;

                        return Column(
                          children: <Widget>[
                            _buildTopRow(height: topRowHeight),
                            const SizedBox(height: space),
                            _buildBottomRow(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            if (isUsingCoin) CoinResult(onClose: onCloseCoin),
            if (isUsingDice) DiceResult(onClose: onCloseDice),
          ],
        ),
      ),
    );
  }
}
