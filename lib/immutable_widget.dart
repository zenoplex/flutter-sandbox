import 'package:flutter/material.dart';

class ImmutableWidget extends StatelessWidget {
  const ImmutableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green,
        padding: const EdgeInsets.all(40),
        child: Container(
            color: Colors.purple,
            padding: const EdgeInsets.all(50),
            child: _buildShinyCircle()));
  }

  Widget _buildShinyCircle() {
    return Container(
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
              colors: [Colors.lightBlueAccent, Colors.blueAccent],
              center: Alignment(-0.3, -0.5)),
          boxShadow: [BoxShadow(blurRadius: 20)]),
    );
  }
}
