import 'package:flutter/material.dart';

class PizzaDetailScreen extends StatefulWidget {
  const PizzaDetailScreen({super.key});

  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
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
                const TextField(
                  decoration: InputDecoration(hintText: 'Insert ID'),
                ),
                const SizedBox(height: 24),
                const TextField(
                  decoration: InputDecoration(hintText: 'Insert Pizza name'),
                ),
                const SizedBox(height: 24),
                const TextField(
                  decoration:
                      InputDecoration(hintText: 'Insert Pizza description'),
                ),
                const SizedBox(height: 24),
                const TextField(
                  decoration: InputDecoration(hintText: 'Insert Price'),
                ),
                const SizedBox(height: 24),
                const TextField(
                  decoration: InputDecoration(hintText: 'Insert Image Url'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(onPressed: () {}, child: const Text('Save')),
              ],
            ),
          ),
        ));
  }
}
