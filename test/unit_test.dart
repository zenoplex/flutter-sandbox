import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sandbox/main.dart';

void main() {
  test('Is even', () {
    bool result = isEven(12);
    expect(result, true);
  });

  test('Is odd', () {
    bool result = isEven(13);
    expect(result, false);
  });
}
