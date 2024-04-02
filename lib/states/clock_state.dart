import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ClockState extends ChangeNotifier {
  static ClockState of(BuildContext context, {bool listen = true}) {
    return Provider.of<ClockState>(context, listen: listen);
  }

  static const Duration _tickFrequency = Duration(milliseconds: 200);

  Timer? _timer;
  final Stopwatch _watch = Stopwatch();
  final Stopwatch _watchA = Stopwatch();
  final Stopwatch _watchB = Stopwatch();

  Duration get currentDuration => _watch.elapsed;
  Duration get currentDurationA => _watchA.elapsed;
  Duration get currentDurationB => _watchB.elapsed;

  bool get isRunning => _watch.isRunning;
  bool get isRunningA => _watchA.isRunning;
  bool get isRunningB => _watchB.isRunning;

  ClockState();

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _watch.stop();
    _watchA.stop();
    _watchB.stop();
    super.dispose();
  }

  void _onTick(Timer timer) {
    print("tick ${timer.tick}");
    notifyListeners();
  }

  void start({
    bool main = false,
    bool clockA = false,
    bool clockB = false,
  }) {
    if (main || clockA || clockB) {
      _timer ??= Timer.periodic(_tickFrequency, _onTick);

      if (main) _watch.start();
      if (clockA) _watchA.start();
      if (clockB) _watchB.start();

      notifyListeners();
    }
  }

  void stopAll({bool notifyListeners = true}) {
    stop(
      main: true,
      clockA: true,
      clockB: true,
      notifyListeners: notifyListeners,
    );
  }

  void stop({
    bool main = false,
    bool clockA = false,
    bool clockB = false,
    bool notifyListeners = true,
  }) {
    if (main) _watch.stop();
    if (clockA) _watchA.stop();
    if (clockB) _watchB.stop();

    if (!_watch.isRunning && !_watchA.isRunning && !_watchB.isRunning) {
      _timer?.cancel();
      _timer = null;
    }

    print('notifyListeners $notifyListeners');
    if (notifyListeners) this.notifyListeners();
  }

  /// Set all watches to 0
  void resetAll() => reset(clockA: true, clockB: true, main: true);

  /// Set selected watches to 0
  void reset({
    bool main = false,
    bool clockA = false,
    bool clockB = false,
  }) {
    // stop();
    // _watch.reset();
    // _currentDuration = Duration.zero;
    if (main) _watch.reset();
    if (clockA) _watchA.reset();
    if (clockB) _watchB.reset();

    notifyListeners();
  }
}
