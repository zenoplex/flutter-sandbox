import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  final String name;
  final String email;
  const StopWatch({super.key, required this.name, required this.email});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int milliseconds = 0;
  final laps = <int>[];
  Timer? timer;
  bool isTicking = false;
  final itemHeight = 50.0;
  final scrollController = ScrollController();

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

  void _stopTimer(BuildContext context) {
    if (timer != null) timer!.cancel();

    setState(() {
      isTicking = false;
    });

    final controller = showBottomSheet(
      context: context,
      builder: (_) => _buildRunCompleteSheet(context),
    );

    Future.delayed(const Duration(seconds: 3), () async {
      controller.close();
    });
  }

  Widget _buildRunCompleteSheet(BuildContext context) {
    final totalRuntime = laps.fold(milliseconds, (total, lap) => total + lap);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Container(
        color: Theme.of(context).bannerTheme.backgroundColor,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Run finished!',
                style: textTheme.headlineSmall,
              ),
              Text('Total run time is ${_secondsText(totalRuntime)}'),
            ],
          ),
        ),
      ),
    );
  }

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });

    // maxScrollExtent does not return the correct value until the next frame
    // Thus added itemHeight to ensure its scrolling to the bottom of the list
    // However, this seems to only work with ClampingScrollPhysics()
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + itemHeight,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: SafeArea(
        child: Column(
          children: [
            _buildCounter(context),
            Expanded(
              child: _buildLapDisplay(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white),
          ),
          Text(
            _secondsText(milliseconds),
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white),
          ),
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
          child: const Text('Lap'),
        ),
        const SizedBox(
          width: 20,
        ),
        Builder(
          builder: (context) => ElevatedButton(
            onPressed: isTicking ? () => _stopTimer(context) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Stop'),
          ),
        ),
      ],
    );
  }

  Widget _buildLapDisplay() {
    return Scrollbar(
      controller: scrollController,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        controller: scrollController,
        itemExtent: itemHeight,
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
    if (timer != null) timer!.cancel();
    scrollController.dispose();
    super.dispose();
  }
}
