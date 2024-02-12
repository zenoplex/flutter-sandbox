import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master plan')),
      body: _buildList(),
      floatingActionButton: _buildActionButton(),
    );
  }

  Widget _buildActionButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {},
    );
  }

  Widget _buildList() => const Placeholder();
}
