import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class MlHelper {
  Future<String> textFromImage(File image) async {
    final textRecognizer = TextRecognizer();
    final InputImage inputImage = InputImage.fromFile(image);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }
}
