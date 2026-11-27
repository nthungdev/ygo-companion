/// Convert a [Duration] to 00:00 format String
/// Ex: 14:49 as 14 minutes and 49 seconds
String durationToDigital(Duration duration) {
  final totalSeconds = duration.inSeconds;
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;

  return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}

/// Tidy up the parentheses in a list of expression tokens:
/// - drops a ")" that has no matching "("
/// - appends the ")" missing for each unclosed "("
/// - drops empty "()" pairs
List<String> cleanParentheses(List<String> tokens) {
  final result = <String>[];
  var depth = 0;

  for (final token in tokens) {
    if (token == "(") {
      depth++;
      result.add(token);
    } else if (token == ")") {
      if (depth == 0) continue;
      depth--;
      if (result.isNotEmpty && result.last == "(") {
        // empty pair "()"
        result.removeLast();
      } else {
        result.add(token);
      }
    } else {
      result.add(token);
    }
  }

  // Close what is still open. Drop an opening "(" that would end up empty.
  while (depth > 0) {
    if (result.isNotEmpty && result.last == "(") {
      result.removeLast();
    } else {
      result.add(")");
    }
    depth--;
  }

  return result;
}

/// Join tokens with single spaces, except no space after "(" or before ")".
String _joinTokens(List<String> tokens) {
  final buffer = StringBuffer();
  for (var i = 0; i < tokens.length; i++) {
    if (i > 0 && tokens[i - 1] != "(" && tokens[i] != ")") {
      buffer.write(" ");
    }
    buffer.write(tokens[i]);
  }
  return buffer.toString();
}

/// Clean up unnecessary stuff in the expression
/// Returns null if invalid
String? formatExpression(String expression) {
  const operators = "+-*/÷x";
  const numeric = "0123456789";
  const specials = "()";
  // Symbols
  List<String> l = [];
  if (expression.isEmpty || !operators.contains(expression[0])) {
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
      if (c == "x") {
        l.add("*");
      } else if (c == "÷") {
        l.add("/");
      } else {
        l.add(c);
      }
    } else if (specials.contains(c)) {
      l.add(c);
    }
  }

  l = cleanParentheses(l);

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
      } else {
        formatted.add(item);
      }
    } else {
      formatted.add(item);
    }

    i++;
  }
  return _joinTokens(formatted);
}
