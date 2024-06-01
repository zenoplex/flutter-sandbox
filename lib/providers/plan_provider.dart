import 'package:flutter/material.dart';
import 'package:flutter_sandbox/models/data_layer.dart';

class PlanProvider extends InheritedNotifier<ValueNotifier<Plans>> {
  const PlanProvider({
    super.key,
    required super.child,
    required ValueNotifier<Plans> super.notifier,
  });

  static ValueNotifier<Plans> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PlanProvider>()!
        .notifier!;
  }
}
