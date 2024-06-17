// NOTE: I'm not sure this is how routing should be handled.
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/pages/animation_demo.dart';
import 'package:flutter_sandbox/pages/area_demo.dart';
import 'package:flutter_sandbox/pages/authentication/authentication_demo.dart';
import 'package:flutter_sandbox/pages/basic_screen/basic_screen.dart';
import 'package:flutter_sandbox/pages/camera/camera_demo.dart';
import 'package:flutter_sandbox/pages/deep_tree.dart';
import 'package:flutter_sandbox/pages/dismissible_demo.dart';
import 'package:flutter_sandbox/pages/e_commerce_screen.dart';
import 'package:flutter_sandbox/pages/fade_transition_demo.dart';
import 'package:flutter_sandbox/pages/fade_transition_list_demo.dart';
import 'package:flutter_sandbox/pages/flex_screen/flex_screen.dart';
import 'package:flutter_sandbox/pages/future_demo.dart';
import 'package:flutter_sandbox/pages/geolocation_demo.dart';
import 'package:flutter_sandbox/pages/google_map_demo.dart';
import 'package:flutter_sandbox/pages/hero_animation_demo.dart';
import 'package:flutter_sandbox/pages/immutable_widget.dart';
import 'package:flutter_sandbox/pages/json_demo.dart';
import 'package:flutter_sandbox/pages/language_identifier/language.dart';
import 'package:flutter_sandbox/pages/navigation/navigation_first.dart';
import 'package:flutter_sandbox/pages/navigation_dialog.dart';
import 'package:flutter_sandbox/pages/pizzas/pizza_demo.dart';
import 'package:flutter_sandbox/pages/plans/plan_creator_screen.dart';
import 'package:flutter_sandbox/pages/random_bloc/random_bloc_demo.dart';
import 'package:flutter_sandbox/pages/shape_animation_demo.dart';
import 'package:flutter_sandbox/pages/stopwatch/stopwatch_login_screen.dart';
import 'package:flutter_sandbox/pages/stream/stream_builder_app.dart';
import 'package:flutter_sandbox/pages/stream/stream_demo.dart';

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
  '/camera_demo': CustomRoute.fromWidget(
    label: 'Camera',
    widget: const CameraDemo(),
  ),
  '/deep_tree_demo': CustomRoute.fromWidget(
    label: 'Deep Tree',
    widget: const DeepTree(),
  ),
  '/dismissible_demo': CustomRoute.fromWidget(
    label: 'Dismissible',
    widget: const DismissibleDemo(),
  ),
  '/e_commerce': CustomRoute.fromWidget(
    label: 'ECommerce',
    widget: const ECommerceScreen(),
  ),
  '/fade_transition_demo': CustomRoute.fromWidget(
    label: 'FadeTransition',
    widget: const FadeTransitionDemo(),
  ),
  '/fade_transition_list_demo': CustomRoute.fromWidget(
    label: 'FadeTransitionList',
    widget: const FadeTransitionListDemo(),
  ),
  '/flex': CustomRoute.fromWidget(
    label: 'Flex',
    widget: const FlexScreen(),
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
  '/immutable_widget': CustomRoute.fromWidget(
    label: 'Immutable Widget',
    widget: const ImmutableWidget(),
  ),
  '/language_identifier': CustomRoute.fromWidget(
    label: 'Language Identifier',
    widget: const LanguageScreen(),
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
  '/plan': CustomRoute.fromWidget(
    label: 'Plan',
    widget: const PlanCreatorScreen(),
  ),
  '/random_bloc': CustomRoute.fromWidget(
    label: 'Random Bloc Demo',
    widget: const RandomBlocDemo(),
  ),
  '/shape_animation': CustomRoute.fromWidget(
    label: 'Shape Animation',
    widget: const ShapeAnimationDemo(),
  ),
  '/stopwatch': CustomRoute.fromWidget(
    label: 'Stop Watch Demo',
    widget: const StopWatchLoginScreen(),
  ),
  '/stream': CustomRoute.fromWidget(
    label: 'Stream',
    widget: const StreamHomePage(),
  ),
  '/stream_builder': CustomRoute.fromWidget(
    label: 'Stream Builder',
    widget: const StreamBuilderApp(),
  ),
};

class CustomRoute {
  final String label;
  final Widget Function(BuildContext) fn;

  CustomRoute({required this.label, required this.fn});

  CustomRoute.fromWidget({required this.label, required Widget widget})
      : fn = ((BuildContext context) => widget);
}
