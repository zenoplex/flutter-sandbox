import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlert {
  final String title;
  final String message;

  const PlatformAlert({required this.title, required this.message});

  void show(BuildContext context) {
    final platform = Theme.of(context).platform;
    switch (platform) {
      case TargetPlatform.iOS:
        _buildCupertinoAlert(context);
      default:
        _buildMaterialAlert(context);
    }
  }

  void _buildCupertinoAlert(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return _buildAlertDialog(context);
        },);
  }

  void _buildMaterialAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return _buildAlertDialog(context);
        },);
  }

  AlertDialog _buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
