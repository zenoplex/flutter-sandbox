import 'package:flutter/material.dart';
import 'package:flutter_sandbox/random_bloc.dart';

class RandomBlocScreen extends StatefulWidget {
  const RandomBlocScreen({super.key});

  @override
  State<RandomBlocScreen> createState() => _RandomBlocScreenState();
}

class _RandomBlocScreenState extends State<RandomBlocScreen> {
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
