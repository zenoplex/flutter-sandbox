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
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
  ];
  int iteration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Demo'),
        actions: [IconButton(onPressed: (){
          setState(() {
            iteration = (iteration + 1) % colors.length;
          });
        }, icon: const Icon(Icons.run_circle),),],
      ),
      body: Center(
        child: AnimatedContainer(
          width: 100,
          height: 100,
          duration: const Duration(seconds: 1),
          color: colors[iteration],
        ),
      ),
    );
  }
}
