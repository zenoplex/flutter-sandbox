import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Picture extends StatelessWidget {
  final XFile picture;
  const Picture(
    this.picture, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text('Picture')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(picture.path),
          SizedBox(
            height: deviceHeight / 1.5,
            child: Image.file(File(picture.path)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Text Recognition'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
