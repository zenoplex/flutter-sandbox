import 'package:flutter/material.dart';

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({super.key});

  @override
  State<AnimationDemo> createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> {
  final List<Color> colors = const [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
  ];
  final List<double> sizes = const [100, 125, 150, 175, 200];
  final List<double> tops = const [0, 50, 100, 150, 200];
  int iteration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Demo'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                iteration = (iteration + 1) % colors.length;
              });
            },
            icon: const Icon(Icons.run_circle),
          ),
        ],
      ),
      body: Center(
        child: AnimatedContainer(
          width: sizes[iteration],
          height: sizes[iteration],
          duration: const Duration(milliseconds: 500),
          color: colors[iteration],
          margin: EdgeInsets.only(top: tops[iteration]),
          curve: Curves.easeOutExpo,
        ),
      ),
    );
  }
}
