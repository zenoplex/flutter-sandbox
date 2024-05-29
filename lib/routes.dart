// NOTE: I'm not sure this is how routing should be handled.
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/basic_screen.dart';
import 'package:flutter_sandbox/views/animation_demo.dart';
import 'package:flutter_sandbox/views/area_demo.dart';
import 'package:flutter_sandbox/views/authentication_demo.dart';

final routes = {
  '/': CustomRoute(label: 'Home', fn: (context) => const BasicScreen()),
  '/animation_demo': CustomRoute.fromWidget(
    label: 'AnimationDemo',
    widget: const AnimationDemo(),
  ),
  '/authentication_demo': CustomRoute.fromWidget(
    label: 'AuthenticationDemo',
    widget: const AuthenticationDemo(),
  ),
  '/area_demo': CustomRoute.fromWidget(
    label: 'AreaDemo',
    widget: const AreaApp(),
  ),
};

class CustomRoute {
  final String label;
  final Widget Function(BuildContext) fn;

  CustomRoute({required this.label, required this.fn});

  CustomRoute.fromWidget({required this.label, required Widget widget})
      : fn = ((BuildContext context) => widget);
}
