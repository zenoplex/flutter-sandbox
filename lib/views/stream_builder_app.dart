import 'package:flutter/material.dart';
import 'package:flutter_sandbox/number_stream.dart';

class StreamBuilderApp extends StatefulWidget {
  const StreamBuilderApp({super.key});

  @override
  State<StreamBuilderApp> createState() => _StreamBuilderAppState();
}

class _StreamBuilderAppState extends State<StreamBuilderApp> {
  final Stream<int> numberStream = NumberStream().getNumbers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
      ),
      body: StreamBuilder(
        stream: numberStream,
        initialData: 0,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error.toString()}');
          }

          if (snapshot.hasData) {
            return Center(
              child: Text(
                snapshot.data.toString(),
                style: const TextStyle(fontSize: 96),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
