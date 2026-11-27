import 'package:flutter_test/flutter_test.dart';
import 'package:ygo_companion/utils/formatter.dart';

void main() {
  group('cleanParentheses', () {
    test('keeps balanced parentheses', () {
      expect(cleanParentheses(['(', '1', '+', '2', ')']),
          ['(', '1', '+', '2', ')']);
    });

    test('closes unclosed parentheses', () {
      expect(cleanParentheses(['(', '(', '1', '+', '2', ')']),
          ['(', '(', '1', '+', '2', ')', ')']);
    });

    test('drops unmatched closing parentheses', () {
      expect(cleanParentheses(['1', ')', '+', '2', ')']), ['1', '+', '2']);
    });

    test('drops empty pairs', () {
      expect(cleanParentheses(['+', '(', ')', '1']), ['+', '1']);
      expect(cleanParentheses(['+', '1', '(']), ['+', '1']);
    });
  });

  group('formatExpression', () {
    test('returns null for empty or invalid expressions', () {
      expect(formatExpression(''), isNull);
      expect(formatExpression('100'), isNull);
      expect(formatExpression('-'), isNull);
    });

    test('formats a plain expression', () {
      expect(formatExpression('-100'), '- 100');
      expect(formatExpression('+100x2'), '+ 100 * 2');
    });

    test('adds missing closing parenthesis', () {
      expect(formatExpression('-(100+200'), '- (100 + 200)');
    });

    test('removes stray closing parenthesis', () {
      expect(formatExpression('-100)'), '- 100');
    });

    test('removes empty parentheses', () {
      expect(formatExpression('-()100'), '- 100');
    });
  });
}
