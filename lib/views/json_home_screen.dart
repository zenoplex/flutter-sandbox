import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sandbox/models/pizza.dart';

class JsonHomePage extends StatefulWidget {
  const JsonHomePage({super.key});

  @override
  State<JsonHomePage> createState() => _JsonHomePageState();
}

class _JsonHomePageState extends State<JsonHomePage> {
  List _pizzas = [];

  @override
  void initState() {
    super.initState();
    readJsonFile().then((value) {
      setState(() {
        _pizzas = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON'),
      ),
      body: ListView.builder(
        itemCount: _pizzas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('$index'),
          );
        },
      ),
    );
  }

  Future<List<Pizza>> readJsonFile() async {
    String data =
        await DefaultAssetBundle.of(context).loadString('assets/pizzas.json');

    List list = jsonDecode(data);
    List<Pizza> pizzas = list.map((item) => Pizza.fromJson(item)).toList();
    return pizzas;
  }
}
