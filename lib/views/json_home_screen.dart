import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sandbox/models/pizza.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class JsonHomePage extends StatefulWidget {
  const JsonHomePage({super.key});

  @override
  State<JsonHomePage> createState() => _JsonHomePageState();
}

class _JsonHomePageState extends State<JsonHomePage> {
  int appCounter = 0;
  String documentPath = '';
  String tmpPath = '';
  List _pizzas = [];

  @override
  void initState() {
    super.initState();
    readAndWritePreference();
    getPaths();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('You have opened this app $appCounter times.'),
              ElevatedButton(
                onPressed: () {
                  deletePreference();
                },
                child: const Text('Reset'),
              )
            ],
          ),
          Text('Document Path: $documentPath'),
          Text('Temporary Path: $tmpPath'),
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }

  Future<List<Pizza>> readJsonFile() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/pizzas_broken.json');

    List list = jsonDecode(data);
    List<Pizza> pizzas = list.map((item) => Pizza.fromJson(item)).toList();

    print(convertToJson(pizzas));

    return pizzas;
  }

  String convertToJson(List<Pizza> pizzas) {
    return jsonEncode(pizzas.map((pizza) => jsonEncode(pizza)).toList());
  }

  Future readAndWritePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt('appCounter') ?? 0;
    count++;

    await prefs.setInt('appCounter', count);

    setState(() {
      appCounter = count;
    });
  }

  Future deletePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    setState(() {
      appCounter = 0;
    });
  }

  Future getPaths() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tmpDir = await getTemporaryDirectory();

    setState(() {
      documentPath = docDir.path;
      tmpPath = tmpDir.path;
    });
  }
}
