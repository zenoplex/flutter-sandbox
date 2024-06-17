import 'dart:io';

import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
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

  Future<String> labelImage(File image) async {
    final options = ImageLabelerOptions();
    final imageLabeler = ImageLabeler(options: options);
    final inputImage = InputImage.fromFile(image);
    final imageLabels = await imageLabeler.processImage(inputImage);

    final str = imageLabels.fold("", (acc, label) {
      final text = "${label.label} - ${label.confidence * 100}";
      return "$acc$text\n";
    });

    return str.trim();
  }

  /// Note: Face detection does not seem to work properly on iOS
  Future<String> detectFace(File image) async {
    final options = FaceDetectorOptions(
      enableClassification: true,
      enableTracking: true,
      enableLandmarks: true,
      enableContours: true,
      performanceMode: FaceDetectorMode.accurate,
    );
    final faceDetector = FaceDetector(options: options);
    final inputImage = InputImage.fromFile(image);
    final faces = await faceDetector.processImage(inputImage);

    final str = faces.asMap().entries.fold("", (acc, entry) {
      final face = entry.value;
      final text = """
Face: ${entry.key}
Smiling: ${face.smilingProbability ?? 0 * 100}%
Left eye open: ${face.leftEyeOpenProbability ?? 0 * 100}%
Right eye open: ${face.rightEyeOpenProbability ?? 0 * 100}%
""";
      return "$acc$text\n";
    });

    final result = faces.isNotEmpty ? str.trim() : "No faces detected";

    return result;
  }

  Future<String> identifyLanguage(String text) async {
    final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
    final languages = await languageIdentifier.identifyPossibleLanguages(text);

    final str = languages.fold("", (acc, language) {
      final text = "${language.languageTag} - ${language.confidence * 100}";
      return "$acc$text\n";
    });

    return str.isEmpty ? "Unknown language" : str.trim();
  }
}
