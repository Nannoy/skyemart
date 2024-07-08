class Product {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final double? price;
  final String dateCreated;

  Product({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.price,
    required this.dateCreated,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    String? imageUrl;
    if (json['photos'] != null && json['photos'].isNotEmpty) {
      imageUrl = json['photos'][0]['url'];
    }

    double? price;
    if (json['current_price'] != null && json['current_price'].isNotEmpty) {
      price = json['current_price'][0]['USD'][0];
    }

    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: imageUrl,
      price: price,
      dateCreated: json['date_created'],
    );
  }
}
