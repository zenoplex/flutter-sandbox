part of area;

String calculateAreaTriangle(double width, double height) {
  final NumberFormat formatter = NumberFormat("#,###");
  final double result = 0.5 * width * height;
  return formatter.format(result);
}
