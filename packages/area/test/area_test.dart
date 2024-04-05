import 'package:area/area.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('calculateAreaRect', () {
    final List<({String expected, ({double height, double width}) input})>
        cases = [
      (input: (width: 10.0, height: 10.0), expected: '100'),
      (input: (width: 500.0, height: 100.0), expected: '50,000'),
      (input: (width: 2.0, height: 2.0), expected: '4'),
      (input: (width: 0, height: 2.0), expected: '0'),
      (input: (width: -100, height: 100), expected: '-10,000'),
      (input: (width: 10.5, height: 20.21), expected: '212'),
    ];

    for (final (:input, :expected) in cases) {
      final (:width, :height) = input;
      expect(calculateAreaRect(width, height), expected);
    }
  });

  test('calculateAreaTriangle', () {
    final List<({String expected, ({double height, double width}) input})>
        cases = [
      (input: (width: 10.0, height: 10.0), expected: '50'),
      (input: (width: 500.0, height: 100.0), expected: '25,000'),
      (input: (width: 2.0, height: 2.0), expected: '2'),
      (input: (width: 0, height: 2.0), expected: '0'),
      (input: (width: -100, height: 100), expected: '-5,000'),
      (input: (width: 10.5, height: 20.21), expected: '106'),
    ];

    for (final (:input, :expected) in cases) {
      final (:width, :height) = input;
      expect(calculateAreaTriangle(width, height), expected);
    }
  });
}
