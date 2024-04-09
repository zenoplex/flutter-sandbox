import 'package:flutter/material.dart';

class ShapeAnimationDemo extends StatefulWidget {
  const ShapeAnimationDemo({super.key});

  @override
  State<ShapeAnimationDemo> createState() => _ShapeAnimationDemoState();
}

class _ShapeAnimationDemoState extends State<ShapeAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationTop;
  late Animation<double> _animationLeft;
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
                Positioned(
                  left: position.left,
                  top: position.top,
                  child: const Ball(),
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
    );
    // _animationLeft = Tween<double>(begin: 0, end: 150).animate(_controller);
    // _animationTop = Tween<double>(begin: 0, end: 500).animate(_controller)
    //   ..addListener(moveBall);
    _animationLeft =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _animationTop =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
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
      position = (
        left: _animationLeft.value * maxPosition.left,
        top: _animationTop.value * maxPosition.top
      );
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
