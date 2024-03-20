import 'dart:math' as math;

import 'package:flutter/material.dart';

class ImmutableWidget extends StatelessWidget {
  const ImmutableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.green),
        foregroundDecoration: const BoxDecoration(
            backgroundBlendMode: BlendMode.colorBurn,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xAA0d6123),
                  Color(0x00000000),
                  Color(0xAA0d6123),
                ],),),
        padding: const EdgeInsets.all(40),
        child: Center(
            child: Transform.rotate(
          angle: math.pi / 4,
          child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.deepPurple.withAlpha(120),
                        spreadRadius: 4,
                        blurRadius: 15,
                        offset: Offset.fromDirection(1.0, 30),),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),),
              child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: _buildShinyCircle(),),),
        ),),);
  }

  Widget _buildShinyCircle() {
    return Container(
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
              colors: [Colors.lightBlueAccent, Colors.blueAccent],
              center: Alignment(-0.3, -0.5),),
          boxShadow: [BoxShadow(blurRadius: 20)],),
    );
  }
}
