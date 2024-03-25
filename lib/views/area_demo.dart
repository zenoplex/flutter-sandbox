import 'package:area/area.dart';
import 'package:flutter/material.dart';

class AreaApp extends StatefulWidget {
  const AreaApp({super.key});

  @override
  State<AreaApp> createState() => _AreaAppState();
}

class _AreaAppState extends State<AreaApp> {
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Package App'),
      ),
      body: Column(
        children: [
          AppTextField(widthController, 'Width'),
          AppTextField(heightController, 'Height'),
          ElevatedButton(
            onPressed: () {
              final double width = double.tryParse(widthController.text) ?? 0;
              final double height = double.tryParse(heightController.text) ?? 0;
              final String res = calculateAreaRect(width, height);

              setState(() {
                result = res;
              });
            },
            child: const Text('Calculate Area'),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(result),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widthController.dispose();
    heightController.dispose();
    super.dispose();
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const AppTextField(this.controller, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: label),
      ),
    );
  }
}
