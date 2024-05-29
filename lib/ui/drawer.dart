import 'package:flutter/material.dart';
import 'package:flutter_sandbox/routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void _handleTap(BuildContext context, String route) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ...routes.entries.map((route) {
            return ListTile(
              title: Text(route.key),
              onTap: () {
                _handleTap(context, route.value);
              },
            );
          }),
        ],
      ),
    );
  }
}
