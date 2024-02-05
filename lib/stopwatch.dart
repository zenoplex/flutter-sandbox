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
  bool isTicking = false;

  void _onTick(Timer timer) {
    if (!mounted) return;

    setState(() {
      seconds++;
    });
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    setState(() {
      seconds = 0;
      isTicking = true;
    });
  }

  void _stopTimer() {
    timer.cancel();

    setState(() {
      isTicking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Stopwatch')),
        body: SafeArea(
          child: Column(
            children: [
              Text('$seconds ${_secondsText()}',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: isTicking ? null : _startTimer,
                    child: const Text('Start'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: !isTicking ? null : _stopTimer,
                    child: const Text('Stop'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  String _secondsText() => seconds <= 1 ? 'second' : 'seconds';

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
