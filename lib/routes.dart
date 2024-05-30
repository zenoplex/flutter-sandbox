// NOTE: I'm not sure this is how routing should be handled.
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/pages/animation_demo.dart';
import 'package:flutter_sandbox/pages/area_demo.dart';
import 'package:flutter_sandbox/pages/authentication_demo.dart';
import 'package:flutter_sandbox/pages/basic_screen.dart';
import 'package:flutter_sandbox/pages/dismissible_demo.dart';
import 'package:flutter_sandbox/pages/fade_transition_demo.dart';
import 'package:flutter_sandbox/pages/fade_transition_list_demo.dart';
import 'package:flutter_sandbox/pages/future_demo.dart';
import 'package:flutter_sandbox/pages/geolocation_demo.dart';
import 'package:flutter_sandbox/pages/google_map_demo.dart';
import 'package:flutter_sandbox/pages/hero_animation_demo.dart';
import 'package:flutter_sandbox/pages/json_demo.dart';
import 'package:flutter_sandbox/pages/navigation/navigation_first.dart';
import 'package:flutter_sandbox/pages/navigation_dialog.dart';
import 'package:flutter_sandbox/pages/pizzas/pizza_demo.dart';
import 'package:flutter_sandbox/pages/random_bloc/random_bloc_demo.dart';

final routes = {
  '/': CustomRoute(label: 'Home', fn: (context) => const BasicScreen()),
  '/animation_demo': CustomRoute.fromWidget(
    label: 'Animation',
    widget: const AnimationDemo(),
  ),
  '/authentication_demo': CustomRoute.fromWidget(
    label: 'Authentication',
    widget: const AuthenticationDemo(),
  ),
  '/area_demo': CustomRoute.fromWidget(
    label: 'Area Calculation',
    widget: const AreaApp(),
  ),
  '/dismissible_demo': CustomRoute.fromWidget(
    label: 'Dismissible',
    widget: const DismissibleDemo(),
  ),
  '/fade_transition_demo': CustomRoute.fromWidget(
    label: 'FadeTransition',
    widget: const FadeTransitionDemo(),
  ),
  '/fade_transition_list_demo': CustomRoute.fromWidget(
    label: 'FadeTransitionList',
    widget: const FadeTransitionListDemo(),
  ),
  '/future_demo': CustomRoute.fromWidget(
    label: 'Future',
    widget: const FutureScreen(),
  ),
  '/geolocation_demo': CustomRoute.fromWidget(
    label: 'Geolocation',
    widget: const LocationScreen(),
  ),
  '/google_map_demo': CustomRoute.fromWidget(
    label: 'Google Map',
    widget: const GoogleMapApp(),
  ),
  '/hero_animation_demo': CustomRoute.fromWidget(
    label: 'Hero Animation',
    widget: HeroAnimationDemo(),
  ),
  '/json_demo_2_demo': CustomRoute.fromWidget(
    label: 'Pizza Demo',
    widget: const PizzaDemo(),
  ),
  '/json_demo': CustomRoute.fromWidget(
    label: 'JSON Demo',
    widget: const JsonDemo(),
  ),
  '/navigation_dialog': CustomRoute.fromWidget(
    label: 'Navigation Dialog Demo',
    widget: const NavigationDialog(),
  ),
  '/navigation': CustomRoute.fromWidget(
    label: 'Navigation Demo',
    widget: const NavigationFirst(),
  ),
  '/random_bloc': CustomRoute.fromWidget(
    label: 'Random Bloc Demo',
    widget: const RandomBlocDemo(),
  ),
};

class CustomRoute {
  final String label;
  final Widget Function(BuildContext) fn;

  CustomRoute({required this.label, required this.fn});

  CustomRoute.fromWidget({required this.label, required Widget widget})
      : fn = ((BuildContext context) => widget);
}
