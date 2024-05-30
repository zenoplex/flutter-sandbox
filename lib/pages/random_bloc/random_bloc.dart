import 'dart:async';
import 'dart:math';

class RandomNumberBloc {
  final StreamController<void> _generateRandomController = StreamController();
  final StreamController<int> _randomNumberController = StreamController();
  Sink<void> get generateRandom => _generateRandomController.sink;
  Stream<int> get randomNumber => _randomNumberController.stream;

  RandomNumberBloc() {
    _generateRandomController.stream.listen((event) {
      final random = Random().nextInt(10);
      _randomNumberController.sink.add(random);
    });
  }

  void dispose() {
    _generateRandomController.close();
    _randomNumberController.close();
  }
}
