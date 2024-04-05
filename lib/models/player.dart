class Player {
  static const startingLp = 8000;

  String name;

  /// Life points
  int lp;

  /// Temporary calculation
  String calculation;

  /// Clock
  Duration clock;

  List<String> logs = [startingLp.toString()];

  Player(
    this.name, {
    this.lp = startingLp,
    this.calculation = "",
    this.clock = Duration.zero,
    List<String>? logs,
  }) {
    this.logs = logs ?? this.logs;
  }

  Player copyWith({
    int? lp,
    String? calculation,
    Duration? duration,
    List<String>? logs,
  }) {
    return Player(
      name,
      clock: clock,
      lp: lp ?? this.lp,
      calculation: calculation ?? this.calculation,
      logs: logs ?? this.logs,
    );
  }

  resetLp() {
    lp = startingLp;
  }

  clearLogs() {
    logs = [startingLp.toString()];
  }
}
