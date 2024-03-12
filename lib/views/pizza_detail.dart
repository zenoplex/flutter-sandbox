import 'package:flutter/material.dart';

class PizzaDetailScreen extends StatefulWidget {
  const PizzaDetailScreen({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Pizza Detail')),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '',
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
                ElevatedButton(onPressed: () {}, child: const Text('Save')),
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
}
