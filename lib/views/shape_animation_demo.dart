import 'package:flutter/material.dart';

class ShapeAnimationDemo extends StatefulWidget {
  const ShapeAnimationDemo({super.key});

  @override
  State<ShapeAnimationDemo> createState() => _ShapeAnimationDemoState();
}

class _ShapeAnimationDemoState extends State<ShapeAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  ({double left, double top}) position = (left: 0, top: 0);
  ({double left, double top}) maxPosition = (left: 0, top: 0);
  final int ballSize = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Controller'),
        actions: [
          IconButton(
            onPressed: () {
              _controller.reset();
              _controller.forward();
            },
            icon: const Icon(Icons.run_circle),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            maxPosition = (
              left: constraints.maxWidth - ballSize,
              top: constraints.maxHeight - ballSize
            );
            return Stack(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Positioned(
                      left: _animation.value * maxPosition.left,
                      top: _animation.value * maxPosition.top,
                      child: const Ball(),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(
        reverse: true,
      );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
    );
  }
}
