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
  double position = 0;

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
              icon: const Icon(Icons.run_circle),),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: position,
            top: position,
            child: const Ball(),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 200).animate(_controller)
      ..addListener(moveBall);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void moveBall() {
    setState(() {
      position = _animation.value;
    });
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
