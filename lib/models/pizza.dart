class Pizza {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Pizza.fromJson(Map<String, dynamic> json)
      : id = int.tryParse(json['id'].toString()) ?? 0,
        name = json['pizzaName'] != null
            ? json['pizzaName'].toString()
            : 'No Name',
        description =
            json['description'] != null ? json['description'].toString() : '',
        price = double.tryParse(json['price'].toString()) ?? 0,
        imageUrl = json['imageUrl'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pizzaName': name,
      'description': description,
      'price': price,
      imageUrl: imageUrl,
    };
  }
}
