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
  final NumberStream numberStream = NumberStream();

  @override
  void initState() {
    final Stream stream = numberStream.controller.stream;

    stream.listen((event) {
      setState(() {
        lastNumber = event;
      });
    }).onError((error) {
      setState(() {
        lastNumber = -1;
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(lastNumber.toString()),
              ElevatedButton(
                  onPressed: () {
                    addRandomNumber();
                  },
                  child: const Text('New Random Number'))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    numberStream.close();
    super.dispose();
  }

  void changeColor() async {
    await for (Color eventColor in colorStream.getColors()) {
      setState(() {
        bgColor = eventColor;
      });
    }
  }

  void addRandomNumber() {
    Random random = Random();
    final int num = random.nextInt(10);
    if (num <= 5) {
      numberStream.addError();
      return;
    }
    numberStream.addNumberToSink(num);
  }
}
