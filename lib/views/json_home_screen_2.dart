import 'package:flutter/material.dart';
import 'package:flutter_sandbox/models/pizza.dart';
import 'package:flutter_sandbox/utils/http_helper.dart';

class JsonHomePage extends StatefulWidget {
  const JsonHomePage({super.key});

  @override
  State<JsonHomePage> createState() => _JsonHomePageState();
}

class _JsonHomePageState extends State<JsonHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              return ListView.builder(
                  itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.local_pizza),
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(snapshot.data![index].description),
                      trailing: Text(snapshot.data![index].price.toString()),
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
