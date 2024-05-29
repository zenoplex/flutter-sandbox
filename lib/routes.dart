// NOTE: I'm not sure how should this be handled.
// MaterialApp.routes requires shape of Map<String, Function(BuildContext)> and I'm not sure I should import every page required here.
// I was thinking of having Map<String, Record{ String label, Function(BuildContext) fn }>
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/basic_screen.dart';
import 'package:flutter_sandbox/views/animation_demo.dart';

final routes = {
  '/': CustomRoute(
      label: 'Home', fn: (BuildContext context) => const BasicScreen()),
  '/settings': CustomRoute(
    label: 'AnimationDemo',
    fn: (BuildContext context) => const AnimationDemo(),
  ),
};

class CustomRoute {
  final String label;
  final Widget Function(BuildContext) fn;

  CustomRoute({required this.label, required this.fn});
}
