import 'package:flutter/material.dart';

class FadeTransitionListDemo extends StatefulWidget {
  const FadeTransitionListDemo({super.key});

  @override
  State<FadeTransitionListDemo> createState() => _FadeTransitionListDemoState();
}

class _FadeTransitionListDemoState extends State<FadeTransitionListDemo> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<int> _items = [1, 2, 3, 4, 5];
  int counter = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated List'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return fadeListTile(context, _items[index], animation);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          insertPizza();
        },
      ),
    );
  }

  Widget fadeListTile(
    BuildContext context,
    int item,
    Animation<double> animation,
  ) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.local_pizza),
          title: Text('Pizza $item'),
          onTap: () {
            final index = _items.indexOf(item);
            if (index != -1) {
              removePizza(index);
            }
          },
        ),
      ),
    );
  }

  void removePizza(int index) {
    final int item = _items[index];
    final AnimatedListState? state = _listKey.currentState;
    if (state == null) throw Exception('List key is null');

    state.removeItem(
      index,
      (BuildContext context, Animation<double> animation) =>
          fadeListTile(context, item, animation),
      duration: const Duration(seconds: 1),
    );
    _items.removeAt(index);
  }

  void insertPizza() {
    final AnimatedListState? state = _listKey.currentState;
    if (state == null) throw Exception('List key is null');
    state.insertItem(_items.length, duration: const Duration(seconds: 1));
    _items.add(++counter);
  }
}