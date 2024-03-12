import 'package:flutter/material.dart';
import 'package:flutter_sandbox/models/pizza.dart';
import 'package:flutter_sandbox/utils/http_helper.dart';

class PizzaDetailScreen extends StatefulWidget {
  const PizzaDetailScreen({super.key});

  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  String result = '';
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Pizza Detail')),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  result,
                  style: TextStyle(
                    backgroundColor: Colors.green.shade200,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(hintText: 'Insert ID'),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(hintText: 'Insert Pizza name'),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      hintText: 'Insert Pizza description'),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(hintText: 'Insert Price'),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: imageUrlController,
                  decoration:
                      const InputDecoration(hintText: 'Insert Image Url'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () {
                      postPizza();
                    },
                    child: const Text('Save')),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  Future postPizza() async {
    HttpHelper helper = HttpHelper();
    Pizza pizza = Pizza(
      id: int.tryParse(idController.text) ?? 0,
      name: nameController.text,
      description: descriptionController.text,
      price: double.tryParse(priceController.text) ?? 0,
      imageUrl: imageUrlController.text,
    );
    String res = await helper.postPizza(pizza);
    setState(() {
      result = res;
    });
  }
}
