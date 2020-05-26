/// Convert a [Duration] to 00:00 format String
/// Ex: 14:49 as 14 minutes and 49 seconds
String durationToDigital(Duration duration) {
  final totalSeconds = duration.inSeconds;
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;

  return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}

/// Clean up unnecessary stuff in the expression
String formatExpression(String expression) {
  const operators = "+-*/÷x";
  const numeric = "0123456789";
  List<String> l = [];
  if (!operators.contains(expression[0])) {
    return null;
  }

  for (int i = 0; i < expression.length; i++) {
    final c = expression[i];

    if (numeric.contains(c)) {
      if (i == 0) {
        l.add(c);
      } else if (numeric.contains(expression[i - 1])) {
        l.last += c;
      } else {
        l.add(c);
      }
    } else if (operators.contains(c)) {
      if (c == "x")
        l.add("*");
      else if (c == "÷")
        l.add("/");
      else
        l.add(c);
    }
  }

  List<String> formatted = [];
  int i = 0;
  while (i < l.length) {
    final item = l[i];

    if (operators.contains(item)) {
      if (i == l.length - 1) {
        return null;
        // } else if (formatted.isEmpty && item == "+") {
      } else if (item == "+" && l[i + 1] == "+") {
      } else if (item == "+" && l[i + 1] == "-") {
      } else if (item == "-" && l[i + 1] == "-") {
        l[i + 1] = "+";
      } else if (item == "-" && l[i + 1] == "+") {
        l[i + 1] = "-";
      } else
        formatted.add(item);
    } else {
      formatted.add(item);
    }

    i++;
  }
  return formatted.join(" ");
}
