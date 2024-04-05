import 'package:area/area.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds one to input values', () {
    final List<({String expected, ({double height, double width}) input})>
        cases = [
      (input: (width: 10.0, height: 10.0), expected: '100'),
      (input: (width: 500.0, height: 100.0), expected: '50,000'),
      (input: (width: 2.0, height: 2.0), expected: '4'),
      (input: (width: 0, height: 2.0), expected: '0'),
      (input: (width: -100, height: 100), expected: '-10,000'),
    ];

    for (final (:input, :expected) in cases) {
      final (:width, :height) = input;
      expect(calculateAreaRect(width, height), expected);
    }
  });
}
