import 'package:flutter/material.dart';
import './models/data_layer.dart';

class PlanProvider extends InheritedNotifier<ValueNotifier<Plans>> {
  const PlanProvider(
      {super.key,
      required Widget child,
      required ValueNotifier<Plans> notifier})
      : super(child: child, notifier: notifier);

  static ValueNotifier<Plans> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PlanProvider>()!
        .notifier!;
  }
}
