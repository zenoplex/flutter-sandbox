import 'package:flutter/material.dart';
import 'dart:async';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int seconds = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer timer) {
    if (!mounted) return;

    setState(() {
      seconds++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Stopwatch')),
        body: SafeArea(
          child: Center(
              child: Text('$seconds ${_secondsText()}',
                  style: Theme.of(context).textTheme.headlineSmall)),
        ));
  }

  String _secondsText() => seconds <= 1 ? 'second' : 'seconds';
}
