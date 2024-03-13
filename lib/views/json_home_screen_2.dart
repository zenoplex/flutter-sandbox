import 'package:flutter/material.dart';
import 'package:flutter_sandbox/models/pizza.dart';
import 'package:flutter_sandbox/utils/http_helper.dart';
import 'package:flutter_sandbox/views/pizza_detail.dart';

class JsonHomePage extends StatefulWidget {
  const JsonHomePage({super.key});

  @override
  State<JsonHomePage> createState() => _JsonHomePageState();
}

class _JsonHomePageState extends State<JsonHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PizzaDetailScreen()));
            }),
        appBar: AppBar(
          title: const Text('JSON'),
        ),
        body: FutureBuilder(
            future: callPizzas(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Pizza>> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong.');
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final List<Pizza> data =
                  snapshot.data == null ? [] : snapshot.data!;

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final Pizza pizza = data[index];
                    return ListTile(
                      leading: const Icon(Icons.local_pizza),
                      title: Text(pizza.name),
                      subtitle: Text(pizza.description),
                      trailing: Text(pizza.price.toString()),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PizzaDetailScreen(
                                selectedPizza: pizza,
                              );
                            },
                          ),
                        );
                      },
                    );
                  });
            }));
  }

  Future<List<Pizza>> callPizzas() async {
    HttpHelper helper = HttpHelper();
    List<Pizza> pizzas = await helper.getPizzas();
    return pizzas;
  }
}
