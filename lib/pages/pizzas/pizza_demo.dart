import 'package:flutter/material.dart';
import 'package:flutter_sandbox/models/pizza.dart';
import 'package:flutter_sandbox/pages/pizzas/pizza_detail.dart';
import 'package:flutter_sandbox/utils/http_helper.dart';

class PizzaDemo extends StatefulWidget {
  const PizzaDemo({super.key});

  @override
  State<PizzaDemo> createState() => _PizzaDemoState();
}

class _PizzaDemoState extends State<PizzaDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (context) => const PizzaDetail(),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: const Text('JSON'),
      ),
      body: FutureBuilder(
        future: callPizzas(),
        builder: (BuildContext context, AsyncSnapshot<List<Pizza>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong.');
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Pizza> data = snapshot.data == null ? [] : snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final Pizza pizza = data[index];
              return Dismissible(
                key: Key(pizza.id.toString()),
                onDismissed: (_) async {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);

                  final HttpHelper helper = HttpHelper();
                  final String message = await helper.deletePizza(pizza.id);
                  data.removeWhere((element) => element.id == pizza.id);

                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );
                },
                child: ListTile(
                  leading: const Icon(Icons.local_pizza),
                  title: Text(pizza.name),
                  subtitle: Text(pizza.description),
                  trailing: Text(pizza.price.toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (context) {
                          return PizzaDetail(
                            selectedPizza: pizza,
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Pizza>> callPizzas() async {
    final HttpHelper helper = HttpHelper();
    final List<Pizza> pizzas = await helper.getPizzas();
    return pizzas;
  }
}