import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sandbox/models/pizza.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late File file;
  String fileText = '';
  final passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();
  final pwdKey = 'pwd_key';
  String? pwdValue;

  @override
  void initState() {
    super.initState();
    readAndWritePreference();
    getPaths().then((_) {
      file = File('$documentPath/example.txt');
      writeFile();
    });
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
              ),
            ],
          ),
          Text('Document Path: $documentPath'),
          Text('Temporary Path: $tmpPath'),
          ElevatedButton(
            onPressed: () {
              readFile();
            },
            child: const Text('Read file'),
          ),
          Text(fileText),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  writeToSecureStorage();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(pwdValue ?? 'NOT SET'),
              ElevatedButton(
                child: const Text('Read'),
                onPressed: () async {
                  final value = await readFromSecureStorage();
                  setState(() {
                    pwdValue = value;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _pizzas.length,
              itemBuilder: (context, index) {
                final Pizza? maybePizza = _pizzas[index] as Pizza?;

                if (maybePizza == null) {
                  throw Exception('Unexpected null value');
                }

                final Pizza pizza = maybePizza;

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
    final String data = await DefaultAssetBundle.of(context)
        .loadString('assets/pizzas_broken.json');

    final List<Map<String, dynamic>> list =
        jsonDecode(data) as List<Map<String, dynamic>>;
    final List<Pizza> pizzas =
        list.map((item) => Pizza.fromJson(item)).toList();

    print(convertToJson(pizzas));

    return pizzas;
  }

  String convertToJson(List<Pizza> pizzas) {
    return jsonEncode(pizzas.map((pizza) => jsonEncode(pizza)).toList());
  }

  Future readAndWritePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt('appCounter') ?? 0;
    count++;

    await prefs.setInt('appCounter', count);

    setState(() {
      appCounter = count;
    });
  }

  Future deletePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
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

  Future<bool> writeFile() async {
    try {
      await file.writeAsString('Hello, World! ${DateTime.now()}');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> readFile() async {
    try {
      fileText = await file.readAsString();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future writeToSecureStorage() async {
    await storage.write(key: pwdKey, value: passwordController.text);
  }

  Future<String?> readFromSecureStorage() async {
    return await storage.read(key: pwdKey);
  }
}
