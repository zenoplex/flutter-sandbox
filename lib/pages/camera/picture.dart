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

  void _showResult(BuildContext context, String result) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (context) => ResultScreen(result),
      ),
    );
  }

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
                onPressed: () async {
                  final image = File(picture.path);
                  final MlHelper helper = MlHelper();
                  final result = await helper.textFromImage(image);

                  if (!context.mounted) return;
                  _showResult(context, result);
                },
                child: const Text('Text Recognition'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final image = File(picture.path);
                  final MlHelper helper = MlHelper();
                  final result = await helper.scanBarcode(image);

                  if (!context.mounted) return;
                  _showResult(context, result);
                },
                child: const Text('Barcode Reader'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final image = File(picture.path);
                  final MlHelper helper = MlHelper();
                  final result = await helper.labelImage(image);

                  if (!context.mounted) return;
                  _showResult(context, result);
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
