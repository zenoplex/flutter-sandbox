import 'package:flutter/material.dart';
import 'package:flutter_sandbox/immutable_widget.dart';

class BasicScreen extends StatelessWidget {
  const BasicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: AspectRatio(aspectRatio: 1.0, child: ImmutableWidget())));
  }
}
