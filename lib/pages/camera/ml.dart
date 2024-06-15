import 'dart:io';

import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class MlHelper {
  Future<String> textFromImage(File image) async {
    final textRecognizer = TextRecognizer();
    final InputImage inputImage = InputImage.fromFile(image);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }

  Future<String> scanBarcode(File image) async {
    final barcodeScanner = BarcodeScanner();
    final inputImage = InputImage.fromFile(image);
    final barcodes = await barcodeScanner.processImage(inputImage);

    final str = barcodes.fold("", (acc, barcode) {
      final displayValue = barcode.displayValue ?? "";
      return "$acc$displayValue\n";
    });

    return str.trim();
  }
}
