import 'package:flutter/material.dart';
import 'package:flutter_sandbox/models/pizza.dart';
import 'package:flutter_sandbox/utils/http_helper.dart';

class PizzaDetailScreen extends StatefulWidget {
  final Pizza? selectedPizza;
  const PizzaDetailScreen({super.key, this.selectedPizza});

  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  void initState() {
    if (widget.selectedPizza != null) {
      final pizza = widget.selectedPizza!;
      idController.text = pizza.id.toString();
      nameController.text = pizza.name;
      descriptionController.text = pizza.description;
      priceController.text = pizza.price.toString();
      imageUrlController.text = pizza.imageUrl;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Pizza Detail')),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                      savePizza();
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

  Future savePizza() async {
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final HttpHelper helper = HttpHelper();
    Pizza pizza = Pizza(
      id: int.tryParse(idController.text) ?? 0,
      name: nameController.text,
      description: descriptionController.text,
      price: double.tryParse(priceController.text) ?? 0,
      imageUrl: imageUrlController.text,
    );
    final String message = await (widget.selectedPizza == null
        ? helper.postPizza(pizza)
        : helper.putPizza(PartialPizza.fromPizza(pizza)));

    navigator.pop();

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
