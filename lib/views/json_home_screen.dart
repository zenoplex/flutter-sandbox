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
          final Pizza pizza = _pizzas[index];
          return ListTile(
            title: Text(pizza.name),
            subtitle: Text(pizza.description),
            leading: const Icon(Icons.local_pizza),
            trailing: Text(pizza.price.toString()),
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

    print(convertToJson(pizzas));

    return pizzas;
  }

  String convertToJson(List<Pizza> pizzas) {
    return jsonEncode(pizzas.map((pizza) => jsonEncode(pizza)).toList());
  }
}
