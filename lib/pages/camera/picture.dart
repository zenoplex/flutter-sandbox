import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/pages/camera/ml.dart';
import 'package:flutter_sandbox/pages/camera/result.dart';

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
                onPressed: () {
                  final image = File(picture.path);
                  final MlHelper helper = MlHelper();
                  helper.textFromImage(image).then((result) {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (context) => ResultScreen(result),
                      ),
                    );
                  });
                },
                child: const Text('Text Recognition'),
              ),
              ElevatedButton(
                onPressed: () {
                  final image = File(picture.path);
                  final MlHelper helper = MlHelper();
                  helper.scanBarcode(image).then((result) {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (context) => ResultScreen(result),
                      ),
                    );
                  });
                },
                child: const Text('Barcode Reader'),
              ),
              ElevatedButton(
                onPressed: () {
                  final image = File(picture.path);
                  final MlHelper helper = MlHelper();
                  helper.labelImage(image).then((result) {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (context) => ResultScreen(result),
                      ),
                    );
                  });
                },
                child: const Text('Image Labeling'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
