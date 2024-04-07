import 'package:flutter/material.dart';

class DeepTree extends StatelessWidget {
  const DeepTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterLogo(),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                ],
              ),
              Expanded(
                child: Container(color: Colors.purple),
              ),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
