import 'package:flutter/material.dart';
import 'dart:async';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Stopwatch')),
        body: SafeArea(
          child: Center(
              child: Text('0 seconds',
                  style: Theme.of(context).textTheme.headlineSmall)),
        ));
  }
}
