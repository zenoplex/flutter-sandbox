/// This is a sample package
library area;

import 'package:intl/intl.dart';

final NumberFormat formatter = NumberFormat("#.###");

String calculateAreaRect(double width, double height) {
  final double result = width * height;
  return formatter.format(result);
}

String calculateAreaTriangle(double width, double height) {
  final double result = 0.5 * width * height;
  return formatter.format(result);
}
