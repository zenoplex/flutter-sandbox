import 'package:flutter/material.dart';
import 'dart:async';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int milliseconds = 0;
  final laps = <int>[];
  late Timer timer;
  bool isTicking = false;

  void _onTick(Timer timer) {
    if (!mounted) return;

    setState(() {
      milliseconds += 100;
    });
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);
    setState(() {
      milliseconds = 0;
      laps.clear();
      isTicking = true;
    });
  }

  void _stopTimer() {
    timer.cancel();

    setState(() {
      isTicking = false;
    });
  }

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Stopwatch')),
        body: SafeArea(
            child: Column(
          children: [
            _buildCounter(context),
            Expanded(
              child: _buildLapDisplay(),
            ),
          ],
        )));
  }

  Widget _buildCounter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Lap ${laps.length + 1}',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white)),
          Text(_secondsText(milliseconds),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white)),
          const SizedBox(
            height: 20,
          ),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: isTicking ? null : _startTimer,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text('Start'),
        ),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
            onPressed: isTicking ? _lap : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
            ),
            child: const Text('Lap')),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: isTicking ? _stopTimer : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Stop'),
        ),
      ],
    );
  }

  Widget _buildLapDisplay() {
    return Scrollbar(
      child: ListView.builder(
        itemCount: laps.length,
        itemBuilder: (context, index) {
          final milliseconds = laps[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: Text('Lap ${index + 1}'),
            trailing: Text(_secondsText(milliseconds)),
          );
        },
      ),
    );
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
