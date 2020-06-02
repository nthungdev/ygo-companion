import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:ygo_companion/screens/calculator/layouts/pro_layout_5.dart';
import 'package:ygo_companion/states/calculator_setting_state.dart';
import 'package:ygo_companion/states/calculator_state.dart';
import 'package:ygo_companion/states/coin_state.dart';
import 'package:ygo_companion/states/dice_state.dart';
import 'package:ygo_companion/states/clock_state.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  /// [false] if playerB is selected
  bool _playerASelected = true;
  bool _isPlaying = false;
  bool _isUsingDice = false;
  bool _isUsingCoin = false;
  ClockState _staticClockState;
  bool _usingClockA = true;
  bool _usingClockB = false;
  bool _usingMainClock = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // SystemChrome.setEnabledSystemUIOverlays([]);
    _staticClockState = ClockState.of(context, listen: false);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _staticClockState.stopAll(notifyListeners: false);
    super.dispose();
  }

  void handleClockTap({
    bool forMain = false,
    bool forPlayerA = false,
    bool forPlayerB = false,
  }) {
    if (forMain) {
      if (_staticClockState.isRunning) {
        _usingMainClock = false;
        _staticClockState.stop(main: true);
      } else {
        _usingMainClock = true;
        _staticClockState.start(main: true);
      }
    } else if (forPlayerA) {
      _usingClockA = true;
      _usingClockB = false;
      if (_staticClockState.isRunningA) {
        _staticClockState.stop(clockA: true);
      } else {
        _staticClockState.stop(clockB: true);
        _staticClockState.start(clockA: true);
      }
    } else if (forPlayerB) {
      _usingClockA = false;
      _usingClockB = true;
      if (_staticClockState.isRunningB) {
        _staticClockState.stop(clockB: true);
      } else {
        _staticClockState.stop(clockA: true);
        _staticClockState.start(clockB: true);
      }
    }
  }

  void handleCalculatorInput(String input) {
    final calculatorState = CalculatorState.of(context, listen: false);
    try {
      calculatorState.playerInput(_playerASelected, input);
    } catch (error) {
      showToast(
        'Invalid expression',
        context: context,
        backgroundColor: Colors.red,
        borderRadius: BorderRadius.circular(30),
      );
    }
  }

  void handlePlayerFocused(bool forPlayerA) {
    setState(() {
      _playerASelected = forPlayerA;
    });
  }

  void handlePlayerLpLongPressed(bool forPlayerA) {
    final calculatorState = CalculatorState.of(context, listen: false);
    calculatorState.resetPlayerLP(forPlayerA);
  }

  void handlePlayerClockLongPressed(bool forPlayerA) {
    print('handlePlayerWatchLongPressed forPlayerA $forPlayerA');
    _staticClockState.reset(
      clockA: forPlayerA,
      clockB: !forPlayerA,
    );
  }

  void handleMainClockLongPressed() {
    _staticClockState.reset(main: true);
  }

  void _handlePlayPauseTap() {
    final runningA = _staticClockState.isRunningA;
    final runningB = _staticClockState.isRunningB;
    final running = _staticClockState.isRunning;

    print('_lastUsedIsAWatch $_usingClockA');

    if (running || runningA || runningB) {
      _staticClockState.stop(
        clockA: runningA,
        clockB: runningB,
        main: running,
      );
    } else {
      _staticClockState.start(
        clockA: _usingClockA,
        clockB: _usingClockB,
        main: _usingMainClock,
      );
    }

    setState(() => _isPlaying = !_isPlaying);
  }

  void _handleResetTap() {
    _staticClockState.stop(clockA: true, clockB: true, main: true);
    _staticClockState.resetAll();
    setState(() => _isPlaying = false);
  }

  void _handleRollDice() async {
    setState(() => _isUsingDice = true);
    DiceState.of(context, listen: false).rollDice();
  }

  void _handleFlipCoin() async {
    setState(() => _isUsingCoin = true);
    CoinState.of(context, listen: false).flipCoin();
  }

  @override
  Widget build(BuildContext context) {
    final clockService = ClockState.of(context);
    final calculatorState = CalculatorState.of(context);
    final calculatorSettingState = CalculatorSettingState.of(context);

    final isPlaying = clockService.isRunning || clockService.isRunningA || clockService.isRunningB;

    switch (calculatorSettingState.calculatorLayout) {
      case CalculatorLayout.HN_AV_1:
      case CalculatorLayout.AT_AV_1:
      default:
        return ProLayout5(
          isPlaying: isPlaying,
          mainClockDuration: clockService.currentDuration,
          clockADuration: clockService.currentDurationA,
          clockBDuration: clockService.currentDurationB,
          playerA: calculatorState.playerA,
          playerB: calculatorState.playerB,
          playerASelected: _playerASelected,
          onInputTap: handleCalculatorInput,
          onPlayerFocused: handlePlayerFocused,
          onPlayerATap: () => handlePlayerFocused(true),
          onPlayerBTap: () => handlePlayerFocused(false),
          onPlayerALongPress: () => handlePlayerLpLongPressed(true),
          onPlayerBLongPress: () => handlePlayerLpLongPressed(false),
          onMainClockTap: () => handleClockTap(forMain: true),
          onMainClockLongPressed: handleMainClockLongPressed,
          onPlayerAClockTap: () => handleClockTap(forPlayerA: true),
          onPlayerBClockTap: () => handleClockTap(forPlayerB: true),
          onPlayerAClockLongPressed: () => handlePlayerClockLongPressed(true),
          onPlayerBClockLongPressed: () => handlePlayerClockLongPressed(false),
          onPlayPause: _handlePlayPauseTap,
          onReset: _handleResetTap,
          onDice: _handleRollDice,
          onCoin: _handleFlipCoin,
          onCloseCoin: () => setState(() => _isUsingCoin = false),
          onCloseDice: () => setState(() => _isUsingDice = false),
          isUsingCoin: _isUsingCoin,
          isUsingDice: _isUsingDice,
        );
    }
  }
}
