import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FutureScreen extends StatefulWidget {
  const FutureScreen({super.key});

  @override
  State<FutureScreen> createState() => _FutureScreenState();
}

class _FutureScreenState extends State<FutureScreen> {
  String result = '';
  late Completer<int> completer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back from the Future')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                returnFutureGroup();
              },
              child: const Text('Go!'),
            ),
            const Spacer(),
            Text(result),
            const Spacer(),
            const CircularProgressIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Future<void> returnFutureGroup() async {
    final FutureGroup<int> futureGroup = FutureGroup<int>();
    futureGroup.add(returnOneAsync());
    futureGroup.add(returnTwoAsync());
    futureGroup.add(returnThreeAsync());
    futureGroup.close();
    final value = await futureGroup.future;
    final total =
        value.fold(0, (previousValue, element) => previousValue + element);
    setState(() {
      result = total.toString();
    });
  }

  Future<int> getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }

  Future calculate() async {
    try {
      await Future<void>.delayed(const Duration(seconds: 3));
      // completer.complete(42);
      throw Exception('An error occurred!');
    } catch (_) {
      completer.completeError({});
    }
  }

  Future<Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = '/books/v1/volumes/junbDwAAQBAJ';
    final Uri url = Uri.https(authority, path);
    return http.get(url);
  }

  Future<int> returnOneAsync() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return 3;
  }

  Future count() async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();

    setState(() {
      result = total.toString();
    });
  }
}
