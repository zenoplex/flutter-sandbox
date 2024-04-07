import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sandbox/streams.dart';

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  Color bgColor = Colors.blueGrey;
  final ColorStream colorStream = ColorStream();
  int lastNumber = 0;
  String values = '';
  final NumberStream numberStream = NumberStream();
  final StreamTransformer<int, int> transformer =
      StreamTransformer<int, int>.fromHandlers(
    handleData: (value, sink) {
      sink.add(value * 10);
    },
    handleError: (error, stackTrace, sink) {
      sink.add(-1);
    },
    handleDone: (sink) {
      sink.close();
    },
  );
  late StreamSubscription<int> subscription;
  late StreamSubscription<int> subscription2;

  @override
  void initState() {
    final Stream<int> stream =
        numberStream.controller.stream.asBroadcastStream();
    subscription = stream.transform(transformer).listen((event) {
      setState(() {
        lastNumber = event;
        values += '$event - ';
      });
    });

    subscription.onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });
    subscription.onDone(() {
      print('onDone was called');
    });

    subscription2 = stream.transform(transformer).listen((event) {
      setState(() {
        lastNumber = event;
        values += '$event - ';
      });
    });

    changeColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Demo'),
      ),
      body: Container(
        decoration: BoxDecoration(color: bgColor),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(values),
              Text(lastNumber.toString()),
              ElevatedButton(
                onPressed: () {
                  addRandomNumber();
                },
                child: const Text('New Random Number'),
              ),
              ElevatedButton(
                onPressed: () {
                  stopStream();
                },
                child: const Text('Stop stream'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    numberStream.close();
    subscription.cancel();
    subscription2.cancel();
    super.dispose();
  }

  Future<void> changeColor() async {
    await for (final Color eventColor in colorStream.getColors()) {
      setState(() {
        bgColor = eventColor;
      });
    }
  }

  void addRandomNumber() {
    final Random random = Random();
    final int num = random.nextInt(10);

    if (numberStream.controller.isClosed) {
      return;
    }

    if (num <= 5) {
      numberStream.addError();
      return;
    }
    numberStream.addNumberToSink(num);
  }

  void stopStream() {
    numberStream.close();
  }
}
