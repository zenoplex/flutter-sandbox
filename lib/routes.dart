// NOTE: I'm not sure how should this be handled.
// MaterialApp.routes requires shape of Map<String, Function(BuildContext)> and I'm not sure I should import every page required here.
// I was thinking of having Map<String, Record{ String label, Function(BuildContext) fn }>
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/basic_screen.dart';
import 'package:flutter_sandbox/views/animation_demo.dart';
import 'package:flutter_sandbox/views/area_demo.dart';
import 'package:flutter_sandbox/views/authentication_demo.dart';

final routes = {
  '/': CustomRoute(label: 'Home', fn: (context) => const BasicScreen()),
  '/animation_demo': CustomRoute(
    label: 'AnimationDemo',
    fn: (context) => const AnimationDemo(),
  ),
  '/authentication_demo': CustomRoute(
    label: 'AuthenticationDemo',
    fn: (context) => const AuthenticationDemo(),
  ),
  '/area_demo': CustomRoute(
    label: 'AreaDemo',
    fn: (context) => const AreaApp(),
  ),
};

class CustomRoute {
  final String label;
  final Widget Function(BuildContext) fn;

  CustomRoute({required this.label, required this.fn});
}
