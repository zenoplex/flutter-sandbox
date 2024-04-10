import 'package:flutter/material.dart';

class HeroAnimationDemo extends StatelessWidget {
  final List<String> drinks = ['Coffee', 'Tea', 'Cappuccino', 'Espresso'];

  HeroAnimationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animation'),
      ),
      body: ListView.builder(
        itemCount: drinks.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Hero(
              tag: 'cup$index',
              child: const Icon(Icons.free_breakfast),
            ),
            title: Text(drinks[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (context) {
                    return DetailScreen(index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final int index;

  const DetailScreen(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.amber,
              ),
              child: Hero(
                tag: 'cup$index',
                child: const Icon(Icons.free_breakfast, size: 96),
              ),
            ),
          ),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
