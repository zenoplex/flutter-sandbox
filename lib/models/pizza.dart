const keyId = 'id';
const keyName = 'pizzaName';
const keyDescription = 'description';
const keyPrice = 'price';
const keyImageUrl = 'imageUrl';

class Pizza {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const Pizza({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  Pizza.fromJson(Map<String, dynamic> json)
      : id = int.tryParse(json[keyId].toString()) ?? 0,
        name = json[keyName] != null ? json[keyName].toString() : 'No Name',
        description =
            json[keyDescription] != null ? json[keyDescription].toString() : '',
        price = double.tryParse(json[keyPrice].toString()) ?? 0,
        imageUrl = json[keyImageUrl]?.toString() ?? '';

  Map<String, dynamic> toJson() {
    return {
      keyId: id,
      keyName: name,
      keyDescription: description,
      keyPrice: price,
      keyImageUrl: imageUrl,
    };
  }
}

class PartialPizza {
  final int id;
  final String? name;
  final String? description;
  final double? price;
  final String? imageUrl;

  const PartialPizza({
    required this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
  });

  PartialPizza.fromPizza(Pizza pizza)
      : id = pizza.id,
        name = pizza.name,
        description = pizza.description,
        price = pizza.price,
        imageUrl = pizza.imageUrl;

  Map<String, dynamic> toJson() {
    return {
      keyId: id,
      keyName: name,
      keyDescription: description,
      keyPrice: price,
      keyImageUrl: imageUrl,
    };
  }
}
