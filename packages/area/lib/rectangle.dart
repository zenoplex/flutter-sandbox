part of area;

String calculateAreaRect(double width, double height) {
  final NumberFormat formatter = NumberFormat("#,###");
  final double result = width * height;
  return formatter.format(result);
}