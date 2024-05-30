import 'package:flutter/material.dart';
import 'package:flutter_sandbox/pages/random_bloc/random_bloc.dart';

class RandomBlocDemo extends StatefulWidget {
  const RandomBlocDemo({super.key});

  @override
  State<RandomBlocDemo> createState() => _RandomBlocDemoState();
}

class _RandomBlocDemoState extends State<RandomBlocDemo> {
  final _bloc = RandomNumberBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Number')),
      body: StreamBuilder<int>(
        stream: _bloc.randomNumber,
        initialData: 0,
        builder: (context, snapshot) {
          return Text(
            'Random Number: ${snapshot.data}',
            style: const TextStyle(fontSize: 30),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bloc.generateRandom.add(null);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
